#!/usr/local/bin/webscript

// Library imports

// Project imports
import libs.API.Utils;
import libs.Database.Tables.Balance;
import libs.MainExecuteDB;


public bool Execute( int argc, string args ) throws {
	API.VerifyAccount();

	var accountId    = API.retrieve( "account_id" );
	var amount       = cast<double>( API.retrieve( "amount" ) );
	var currencyCode = API.retrieve( "currency_code" );

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

