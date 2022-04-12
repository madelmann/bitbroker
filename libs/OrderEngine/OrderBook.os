
// Library imports

// Project imports
import libs.Database.Lookups.OrderStatus;
import libs.Database.Tables.Orders;
import libs.Database.Views.VOrderbookTop3;
import libs.Database.Utils;
import Consts;


public namespace OrderBook {

    public TOrdersCollection GetBuyOrders( string instrumentCode ) const throws {
        string query = "SELECT * FROM orders WHERE side = '" + BUY + "' AND status_id = " + cast<string>( OrderStatus.OPEN ) + " AND instrument_code = '" + instrumentCode + "' ORDER BY price DESC, created ASC";

        return GetOrders( query );
    }

    public TOrdersCollection GetSellOrders( string instrumentCode ) const throws {
        string query = "SELECT * FROM orders WHERE side = '" + SELL + "' AND status_id = " + cast<string>( OrderStatus.OPEN ) + " AND instrument_code = '" + instrumentCode + "' ORDER BY price ASC, created ASC";

        return GetOrders( query );
    }

    public TOrdersCollection GetTop3BuyOrders( string instrumentCode ) const throws {
        string query = "SELECT * FROM v_orderbook WHERE side = '" + BUY + "' AND status_id = " + cast<string>( OrderStatus.OPEN ) + " AND instrument_code = '" + instrumentCode + "' ORDER BY price DESC, created ASC LIMIT 3";

        return GetOrders( query );
    }

    public TOrdersCollection GetTop3SellOrders( string instrumentCode ) const throws {
        string query = "SELECT * FROM v_orderbook WHERE side = '" + SELL + "' AND status_id = " + cast<string>( OrderStatus.OPEN ) + " AND instrument_code = '" + instrumentCode + "' ORDER BY price ASC, created ASC LIMIT 3";

        return GetOrders( query );
    }

    public VOrderbookTop3Collection GetTop3Orders( string instrumentCode ) const throws {
        var collection = new VOrderbookTop3Collection( Database.Handle );
        collection.loadByQuery( "SELECT * FROM v_orderbook_top3 WHERE instrument_code = '" + instrumentCode + "'" );

        return collection;
    }

    private TOrdersCollection GetOrders( string query ) const throws {
        var collection = new TOrdersCollection( Database.Handle );
        collection.loadByQuery( query );

        return collection;
    }

}
