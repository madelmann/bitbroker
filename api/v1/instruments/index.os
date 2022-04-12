#!/usr/local/bin/webscript

// Library imports

// Project imports
import libs.API.Utils;
import libs.Database.Tables.Instrument;
import libs.MainProcessJsonDB;


public void Process( int argc, string args ) {
	var instrumentCode = API.retrieve( "instrument_code", "" );

	if ( instrumentCode ) {
		GetInstrument( instrumentCode );
	}
	else {
		GetAllInstruments();
	}
}
	
private void GetAllInstruments() {
	var collection = new TInstrumentCollection( Database.Handle );
	collection.loadByQuery( "SELECT * FROM instrument ORDER BY code ASC" );

	Json.BeginArray( "instruments" );
	foreach ( TInstrumentRecord record : collection ) {
		Json.BeginObject();
		Json.AddElement( "instrument_code", record.Code );
		Json.AddElement( "base", record.Base );
		Json.AddElement( "quote", record.Quote );
		Json.AddElement( "amount_precision", record.AmountPrecision );
		Json.AddElement( "market_precision", record.MarketPrecision );
		Json.AddElement( "min_size", record.MinSize );
		Json.AddElement( "state", record.State );
		Json.EndObject();
	}
	Json.EndArray();
}

private void GetInstrument( string instrumentCode ) throws {
	try {
		var record = new TInstrumentRecord( Database.Handle );
		record.loadByQuery( "SELECT * FROM instrument WHERE code = '" + instrumentCode + "' ORDER BY code ASC" );

		Json.AddElement( "instrument_code", record.Code );
		Json.AddElement( "base", record.Base );
		Json.AddElement( "quote", record.Quote );
		Json.AddElement( "amount_precision", record.AmountPrecision );
		Json.AddElement( "market_precision", record.MarketPrecision );
		Json.AddElement( "min_size", record.MinSize );
		Json.AddElement( "state", record.State );

		return;
	}

	throw "invalid instrument_code";
}

