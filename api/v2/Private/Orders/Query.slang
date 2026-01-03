
// Library imports

// Project imports
import libs.Database.Lookups.OrderStatus;
import libs.Database.Views.VOrdersWithTrades;


public namespace PrivateAPI.OrderAPI
{
    public void Query() modify
    {
        try {
            Database.connect();

            QueryOrders();

            Database.disconnect();
        }
        catch ( string e ) {
            Json.AddElement( "message", e );
        }
        catch ( IException e ) {
            Json.AddElement( "message", e.what() );
        }

        API.Response.Finalize();
    }

    private void QueryOrders() throws
    {
        API.VerifyAccount();

        var accountId = API.retrieve( "account_id" );
        var orderId   = API.retrieve( "order_id", "" );

        if ( orderId ) {
            retrieveSingleOrder( accountId, orderId );
        }
        else {
            retrieveAllOrders( accountId );
        }
    }

    private void retrieveAllOrders( string accountId )
    {
        var orders = new VOrdersWithTradesCollection( Database.Handle );
        orders.loadByQuery( "SELECT * FROM v_orders_with_trades WHERE account_id = '" + accountId + "'" );

        var previousOrderId = "";

        Json.BeginArray( "orders" );

        foreach ( VOrdersWithTradesRecord record : orders ) {
            var newOrder = false;

            if ( record.OrderId != previousOrderId ) {
                newOrder = true;
            }

            if ( newOrder ) {
                string orderStatus;
                switch ( record.StatusId ) {
                    case OrderStatus.OPEN:      { orderStatus = "OPEN";      break; }
                    case OrderStatus.FILLED:    { orderStatus = "FILLED";    break; }
                    case OrderStatus.CANCELLED: { orderStatus = "CANCELLED"; break; }
                }
        
                Json.BeginObject();
                Json.AddElement( "order_id", record.OrderId );
                Json.AddElement( "account_id", record.AccountId );
                Json.AddElement( "last_updated", record.LastModified );
                Json.AddElement( "price", record.Price );
                Json.AddElement( "amount", record.Amount );
                Json.AddElement( "filled_amount", record.FilledAmount );
                Json.AddElement( "instrument_code", record.InstrumentCode );
                Json.AddElement( "side", record.Side );
                Json.AddElement( "status", orderStatus );
                Json.AddElement( "time", record.Created );
                Json.AddElement( "type", record.Type );
                Json.BeginArray( "trades" );
            }

            Json.BeginObject();
            Json.AddElement( "trade_id", record.TradeId );
            Json.AddElement( "order_id", record.OrderId );
            Json.AddElement( "account_id", record.AccountId );
            Json.AddElement( "instrument_code", record.InstrumentCode );
            Json.AddElement( "side", record.Side );
            Json.AddElement( "amount", record.TradeAmount );
            Json.AddElement( "price", record.TradePrice );
            Json.AddElement( "time", record.TradeTime );
            Json.EndObject();

            if ( newOrder ) {
                Json.EndArray();
                Json.EndObject();
            }

            previousOrderId = record.OrderId;
        }

        Json.EndArray();
    }

    private void retrieveSingleOrder( string accountId, string orderId )
    {
        var data = new VOrdersWithTradesCollection( Database.Handle );
        data.loadByQuery( "SELECT * FROM v_orders_with_trades WHERE account_id = '" + accountId + "' AND order_id = '" + orderId + "'" );

        try {
            var order = data.at( 0 );

            string orderStatus;
            switch ( order.StatusId ) {
                case OrderStatus.OPEN:      { orderStatus = "OPEN";      break; }
                case OrderStatus.FILLED:    { orderStatus = "FILLED";    break; }
                case OrderStatus.CANCELLED: { orderStatus = "CANCELLED"; break; }
            }

            Json.BeginObject( "order" );
            Json.AddElement( "order_id", order.OrderId );
            Json.AddElement( "account_id", order.AccountId );
            Json.AddElement( "last_updated", order.LastModified );
            Json.AddElement( "price", order.Price );
            Json.AddElement( "amount", order.Amount );
            Json.AddElement( "filled_amount", order.FilledAmount );
            Json.AddElement( "instrument_code", order.InstrumentCode );
            Json.AddElement( "side", order.Side );
            Json.AddElement( "status", orderStatus );
            Json.AddElement( "time", order.Created );
            Json.AddElement( "type", order.Type );
            Json.BeginArray( "trades" );
            foreach ( VOrdersWithTradesRecord record : data ) {
                Json.BeginObject();
                Json.AddElement( "trade_id", record.TradeId );
                Json.AddElement( "order_id", record.OrderId );
                Json.AddElement( "account_id", record.AccountId );
                Json.AddElement( "instrument_code", record.InstrumentCode );
                Json.AddElement( "side", record.Side );
                Json.AddElement( "amount", record.TradeAmount );
                Json.AddElement( "price", record.TradePrice );
                Json.AddElement( "time", record.TradeTime );
                Json.EndObject();
            }
            Json.EndArray();
        }
        catch {
            Json.AddElement( "error", "NOT_FOUND" );
        }

        Json.EndObject();
    }
}
