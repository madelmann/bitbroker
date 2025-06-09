#!/usr/bin/env webscript

// Library imports

// Project imports
import libs.API.Utils;
import libs.Database.Views.VMarketTicker;
import libs.MainProcessJsonDB;


public void Process( int argc, string args ) {
	var instrumentCode = API.retrieve( "instrument_code", "" );

	if ( instrumentCode ) {
		GetSingleMarketTicker( instrumentCode );
	}
	else {
		GetAllMarketTicker();
	}
}
	
private void GetAllMarketTicker() {
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

private void GetSingleMarketTicker( string instrumentCode ) throws {
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

