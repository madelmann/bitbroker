
// Library imports

// Project imports
import libs.Database.Views.VMarketTicker;


public namespace PublicAPI.MarketTickerAPI
{
    public void Query()
    {
        try {
            Database.connect();

            QueryMarketTicker();

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

    private void QueryMarketTicker()
    {
        var instrumentCode = API.retrieve( "instrument_code", "" );

        if ( instrumentCode ) {
            GetSingleMarketTicker( instrumentCode );
        }
        else {
            GetAllMarketTicker();
        }
    }
        
    private void GetAllMarketTicker()
    {
        var collection = new VMarketTickerCollection( Database.Handle );
        collection.loadByQuery( "SELECT * FROM v_market_ticker ORDER BY instrument_code ASC" );

        Json.BeginArray( "instruments" );
        foreach ( VMarketTickerRecord record : collection ) {
            Json.BeginObject();
            Json.AddElement( "instrument_code", record.InstrumentCode );
            Json.AddElement( "best_ask", record.BestAsk );
            Json.AddElement( "best_bid", record.BestBid );
            Json.AddElement( "last_price", record.LastPrice );
            //Json.AddElement( "time", record.Time );
            Json.AddElement( "time", strftime( "%Y-%m-%dT%H:%M:00" ) );
            Json.EndObject();
        }
        Json.EndArray();
    }

    private void GetSingleMarketTicker( string instrumentCode ) throws
    {
        try {
            var record = new VMarketTickerRecord( Database.Handle );
            record.loadByQuery( "SELECT * FROM v_market_ticker WHERE instrument_code = '" + instrumentCode + "' LIMIT 1" );

            Json.AddElement( "instrument_code", record.InstrumentCode );
            Json.AddElement( "best_ask", record.BestAsk );
            Json.AddElement( "best_bid", record.BestBid );
            Json.AddElement( "last_price", record.LastPrice );
            //Json.AddElement( "time", record.Time );
            Json.AddElement( "time", strftime( "%Y-%m-%dT%H:%M:00" ) );

            return;
        }

        throw "invalid instrument_code";
    }
}

