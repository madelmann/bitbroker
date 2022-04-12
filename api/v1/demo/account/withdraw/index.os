#!/usr/local/bin/webscript

// Library imports

// Project imports
import libs.Database.Tables.Balance;
import libs.MainExecuteDB;


public bool Execute( int argc, string args ) throws {
	if ( !isSet( "account_id" ) ) {
		throw "missing account_id";
	}
	if ( !isSet( "amount" ) ) {
		throw "missing amount";
	}
	if ( !isSet( "currency_code" ) ) {
		throw "missing currency_code";
	}

	var accountId = mysql_real_escape_string( Database.Handle, get( "account_id" ) );
	var amount = cast<double>( mysql_real_escape_string( Database.Handle, get( "amount" ) ) );
	var currencyCode = mysql_real_escape_string( Database.Handle, get( "currency_code" ) );

	var balance = new TBalanceRecord( Database.Handle );
	try {
		balance.loadByQuery( "SELECT * FROM balance WHERE account_id = '" + accountId + "' AND currency_code = '" + currencyCode + "' LIMIT 1" );
	}

	if ( balance.Available < amount ) {
		throw "invalid funds";
	}

	balance.Available -= amount;
	balance.insertOrUpdate();

	return true;
}

