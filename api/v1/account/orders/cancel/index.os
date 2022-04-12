#!/usr/local/bin/webscript

// Library imports

// Project imports
import libs.API.Utils;
import libs.MainExecuteDB;
import libs.OrderEngine.OrderEngine;


public bool Execute( int argc, string args ) modify throws {
	API.VerifyAccount();

	if ( !isSet( "order_id" ) ) {
		throw "missing order_id";
	}

	var accountId = mysql_real_escape_string( Database.Handle, get( "account_id" ) );
	var orderId = mysql_real_escape_string( Database.Handle, get( "order_id" ) );

	return OrderEngine.CancelOrder( accountId, orderId );
}

