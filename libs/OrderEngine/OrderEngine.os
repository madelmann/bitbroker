
// Library imports

// Project imports
import libs.Database.Lookups.OrderStatus;
import libs.Database.Tables.Balance;
import libs.Database.Tables.MarketTicker;
import libs.Database.Tables.Orders;
import libs.Database.Tables.Trade;
import Consts;
import OrderBook;
import OrderChecker;


public namespace OrderEngine {

    public bool CancelOrder( string accountId, string orderId ) modify throws {
        var order = new TOrdersRecord( Database.Handle );
        order.loadByQuery( "SELECT * FROM orders WHERE order_id = '" + orderId + "' AND account_id = '" + accountId + "' LIMIT 1" );

        if ( order.StatusId > cast<int>( OrderStatus.OPEN ) ) {
            throw "order is already closed";
        }

        Database.begin();

        ReturnLockedBalance( accountId, order );

        order.StatusId = OrderStatus.CANCELLED;
        order.insertOrUpdate();

        Database.commit();

        return true;
    }

    public TOrdersRecord CreateOrder( string accountId, double amount, string instrumentCode, double price, string side, string type ) modify throws {
        var newOrder = new TOrdersRecord( Database.Handle );
        newOrder.AccountId = accountId;
        newOrder.Amount = amount;
        newOrder.Created = strftime( "%Y-%m-%dT%H:%M:%S" );
        newOrder.InstrumentCode = instrumentCode;
        newOrder.Price = price;
        newOrder.Side = side;
        newOrder.StatusId = OrderStatus.OPEN;
        newOrder.Type = type;

        //print( "CreateOrder( " + cast<string>( newOrder ) + " )" );

        if ( !OrderChecker.IsOrderValid( newOrder ) ) {
            print( "Invalid order " + cast<string>( newOrder ) + " received!" );
            return TOrdersRecord null;
        }

        // Start database transaction
        Database.begin();

        // set the order's id, which will be used for all trades
        newOrder.OrderId = GetNextOrderId();

        // try to immediately execute our new order
        ImmediateExecute( newOrder );

        if ( newOrder.Type == "LIMIT" )
        {
            // we need to lock all necessary assets to be able to execute the maker orders at a later point in time

            if ( newOrder.Side == "BUY" ) {
                var quoteBalance = new TBalanceRecord( Database.Handle );
                quoteBalance.loadByQuery( "SELECT *
                                          FROM instrument i
                                          JOIN balance b ON ( i.quote = b.currency_code AND b.account_id = '" + newOrder.AccountId + "' )
                                          WHERE i.code = '" + newOrder.InstrumentCode + "'
                                          LIMIT 1" );

                // all assets that have not yet been used
                quoteBalance.Locked += newOrder.Amount - newOrder.FilledAmount;
                quoteBalance.insertOrUpdate();
            }
            else if ( newOrder.Side == "SELL" ) {
                var baseBalance = new TBalanceRecord( Database.Handle );
                baseBalance.loadByQuery( "SELECT *
                                          FROM instrument i
                                          JOIN balance b ON ( i.base = b.currency_code AND b.account_id = '" + newOrder.AccountId + "' )
                                          WHERE i.code = '" + newOrder.InstrumentCode + "'
                                          LIMIT 1" );

                // all assets that have not yet been used
                baseBalance.Locked += newOrder.Amount - newOrder.FilledAmount;
                baseBalance.insertOrUpdate();
            }
        }
        else if ( newOrder.Type == "MARKET" ) {
            // Market orders are never stored in our order book, so we need to finish this order
            newOrder.StatusId = OrderStatus.FILLED;
        }

        // store the order in the database no matter if it is executed completely or not
        newOrder.insert();

        // Commit database transaction
        Database.commit();

        return newOrder;
    }

    private TTradeRecord CreateTrade( TOrdersRecord sender, TOrdersRecord receiver, double amount ) modify throws {
        // TODO: updating the sender's and receiver's balance should be done directly in the database

        // update receivers base balance
        var baseBalance = new TBalanceRecord( Database.Handle );
        baseBalance.loadByQuery( "SELECT *
                                   FROM instrument i
                                   JOIN balance b ON ( i.base = b.currency_code AND b.account_id = '" + receiver.AccountId + "' )
                                   WHERE i.code = '" + receiver.InstrumentCode + "'
                                   LIMIT 1" );

        // update receivers quote balance
        var quoteBalance = new TBalanceRecord( Database.Handle );
        quoteBalance.loadByQuery( "SELECT *
                                   FROM instrument i
                                   JOIN balance b ON ( i.quote = b.currency_code AND b.account_id = '" + receiver.AccountId + "' )
                                   WHERE i.code = '" + receiver.InstrumentCode + "'
                                   LIMIT 1" );

        // all assets that have not yet been used
        if ( receiver.Side == "BUY" ) {
            baseBalance.Available += amount;
            quoteBalance.Available -= amount * sender.Price;
        }
        else if ( receiver.Side == "SELL" ) {
            baseBalance.Available -= amount;
            quoteBalance.Available += amount * sender.Price;
        }
        else {
            throw "invalid side received";
        }

        baseBalance.insertOrUpdate();
        quoteBalance.insertOrUpdate();

        // TODO: increase sellers available balance
        // TODO: decrease sellers locked balance

        var trade = new TTradeRecord( Database.Handle );
        trade.AccountId = sender.AccountId;
        trade.Amount = amount;
        trade.InstrumentCode = sender.InstrumentCode;
        trade.OrderId = sender.OrderId;
        trade.Price = sender.Price;
        trade.Side = sender.Side;
        trade.Time = strftime( "%Y-%m-%dT%H:%M:%S" );
        trade.TradeId = GetNextTradeId();
        trade.insertOrUpdate();

        var marketTicker = new TMarketTickerRecord( Database.Handle );
        marketTicker.InstrumentCode = trade.InstrumentCode;
        marketTicker.LastPrice = trade.Price;
        marketTicker.Time = strftime( "%Y-%m-%dT%H:%M:00" );
        marketTicker.insertOrUpdate();

        return trade;
    }

    private string GetNextOrderId() modify {
        // TODO: generate a new order id, possibly from within the database
        srand( time() + rand() );
        return cast<string>( strftime( "%Y-%m-%dT%H:%M:%S" ) ) + "-" + cast<string>( rand() );
    }

    private string GetNextTradeId() modify {
        // TODO: generate a new order id, possibly from within the database
        srand( time() + rand() );
        return cast<string>( strftime( "%Y-%m-%dT%H:%M:%S" ) ) + "-" + cast<string>( rand() );
    }

    private void ImmediateExecute( TOrdersRecord newOrder ) modify throws {
        // look up our order book and check if we can execute the order
        // MARKET ORDER: this should always work (with the exception that not enough maker orders are stored inside our order book)
        // LIMIT ORDER: the remaining part of the order will be stored as a maker order inside of our order book

        if ( newOrder.Side == "BUY" ) {
            var makerOrders = OrderBook.GetSellOrders( newOrder.InstrumentCode );

            // try to match the given order with orders from our order book
            foreach ( TOrdersRecord mo : makerOrders ) {
                // whenever the price of a maker order is below or euqal to our new order we match them
                if ( newOrder.Type == "MARKET" || mo.Price <= newOrder.Price ) {
                    MatchOrder( newOrder, mo );

                    // check if the new order already has been filled completely
                    if ( newOrder.Amount - newOrder.FilledAmount == 0 ) {
                        newOrder.StatusId = OrderStatus.FILLED;
                        return;
                    }

                    continue;
                }
                
                // all possible maker orders have been matched, there's nothing we can do here anymore
                break;
            }
        }
        else if ( newOrder.Side == "SELL" ) {
            var makerOrders = OrderBook.GetBuyOrders( newOrder.InstrumentCode );

            // try to match the given order with orders from our order book
            foreach ( TOrdersRecord mo : makerOrders ) {
                // whenever the price of a maker order is below or equal to our new order we match them
                if ( newOrder.Type == "MARKET" || mo.Price >= newOrder.Price ) {
                    MatchOrder( newOrder, mo );
    
                    // check if the new order already has been filled completely
                    if ( newOrder.Amount - newOrder.FilledAmount == 0 ) {
                        newOrder.StatusId = OrderStatus.FILLED;
                        return;
                    }
    
                    continue;
                }
                
                // all possible maker orders have been matched, there's nothing we can do here anymore
                break;
            }
        }
        else {
            throw "invalid side received";
        }
    }

    private void MatchOrder( TOrdersRecord newOrder, TOrdersRecord storedOrder ) modify {
        //print( "MatchOrder()" );

        double filledAmount;

        if ( storedOrder.Amount - storedOrder.FilledAmount >= newOrder.Amount - newOrder.FilledAmount ) {
            // we can completely fulfill our new order
            filledAmount = newOrder.Amount - newOrder.FilledAmount;
        }
        else {
            // our new order can only partially be filled
            filledAmount = storedOrder.Amount - storedOrder.FilledAmount;
        }

        // update our orders average price
        if ( newOrder.Price ) {
            // TODO: we need to calculate the correct average for all assets
            newOrder.Price = (newOrder.Price + storedOrder.Price ) / 2d;
        }
        else {
            newOrder.Price = storedOrder.Price;
        }

        newOrder.FilledAmount += filledAmount;
        storedOrder.FilledAmount += filledAmount;
        //CreateTrade( storedOrder, newOrder, filledAmount );

        if ( storedOrder.Amount == storedOrder.FilledAmount ) {
            storedOrder.Finished = strftime( "%Y-%m-%dT%H:%M:%S" );
            storedOrder.StatusId = OrderStatus.FILLED;
        }
        storedOrder.insertOrUpdate();
    }

    private void ReturnLockedBalance( string accountId, TOrdersRecord cancelledOrder ) modify throws {
        TBalanceRecord balance;

	if ( cancelledOrder.Side == "BUY" ) {
            // update receivers quote balance
            balance = new TBalanceRecord( Database.Handle );
            balance.loadByQuery( "SELECT *
                                  FROM instrument i
                                  JOIN balance b ON ( i.quote = b.currency_code AND b.account_id = '" + cancelledOrder.AccountId + "' )
                                  WHERE i.code = '" + cancelledOrder.InstrumentCode + "'
                                  LIMIT 1" );

            balance.Available += cancelledOrder.Amount - cancelledOrder.FilledAmount;
        }
	else if ( cancelledOrder.Side == "SELL" ) {
            // update receivers base balance
            balance = new TBalanceRecord( Database.Handle );
            balance.loadByQuery( "SELECT *
                                  FROM instrument i
                                  JOIN balance b ON ( i.base = b.currency_code AND b.account_id = '" + cancelledOrder.AccountId + "' )
                                  WHERE i.code = '" + cancelledOrder.InstrumentCode + "'
                                  LIMIT 1" );

            balance.Available += ( cancelledOrder.Amount - cancelledOrder.FilledAmount ) * cancelledOrder.Price;
        }
        else {
            throw "invalid side received";
        }

        balance.insertOrUpdate();
    }
}

