#!/usr/local/bin/webscript

// Library imports

// Project imports
import libs.Database.Tables.Currency;
import libs.MainProcessJsonDB;


public void Process( int argc, string args ) {
	string currencyCode;
	if ( isSet( "currency_code" ) ) {
		currencyCode = mysql_real_escape_string( Database.Handle, get( "currency_code" ) );
	}

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

