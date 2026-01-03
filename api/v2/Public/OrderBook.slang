
// Library imports

// Project imports
import libs.OrderEngine.OrderBook;


public namespace PublicAPI.OrderBookAPI
{
    public void Query()
    {
        try {
            Database.connect();

            QueryOrderBook();

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

    private void QueryOrderBook() throws
    {
        var instrumentCode = API.retrieve( "instrument_code" );

        GetOrdersByInstrument( instrumentCode );
    }

    private void GetOrdersByInstrument( string instrumentCode )
    {
        var buyOrders = OrderBook.GetTop3BuyOrders( instrumentCode );

        Json.AddElement( "instrument_code", instrumentCode );
        Json.AddElement( "time", strftime( "%Y-%m-%dT%H:%M:%S" ) );
        Json.BeginArray( "asks" );
        foreach ( VOrderbookTop3Record record : buyOrders ) {
            Json.BeginObject();
            Json.AddElement( "amount", record.Amount );
            Json.AddElement( "filled_amount", record.FilledAmount );
            Json.AddElement( "price", record.Price );
            Json.EndObject();
        }
        Json.EndArray();

        var sellOrders = OrderBook.GetTop3SellOrders( instrumentCode );

        Json.BeginArray( "bids" );
        foreach ( VOrderbookTop3Record record : sellOrders ) {
            Json.BeginObject();
            Json.AddElement( "amount", record.Amount );
            Json.AddElement( "filled_amount", record.FilledAmount );
            Json.AddElement( "price", record.Price );
            Json.EndObject();
        }
        Json.EndArray();
    }
}

