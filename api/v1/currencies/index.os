#!/usr/bin/env webscript

// Library imports

// Project imports
import libs.API.Utils;
import libs.Database.Tables.Currency;
import libs.MainProcessJsonDB;


public void Process( int argc, string args ) {
	var currencyCode = API.retrieve( "currency_code", "" );

	if ( currencyCode ) {
		GetCurrency( currencyCode );
	}
	else {
		GetAllCurrencies();
	}
}

private void GetAllCurrencies() {
	var collection = new TCurrencyCollection( Database.Handle );
	collection.loadByQuery( "SELECT * FROM currency ORDER BY code ASC" );

	Json.BeginArray( "currencies" );
	foreach ( TCurrencyRecord record : collection ) {
		Json.BeginObject();
		Json.AddElement( "code", record.Code );
		Json.AddElement( "precision", record.Precision );
		Json.EndObject();
	}
	Json.EndArray();
}

private void GetCurrency( string currencyCode ) {
	var collection = new TCurrencyCollection( Database.Handle );
	collection.loadByQuery( "SELECT * FROM currency WHERE code = '" + currencyCode + "' ORDER BY code ASC" );

	foreach ( TCurrencyRecord record : collection ) {
		Json.AddElement( "code", record.Code );
		Json.AddElement( "precision", record.Precision );
	}
}

