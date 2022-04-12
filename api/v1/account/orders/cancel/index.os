#!/usr/local/bin/webscript

// Library imports

// Project imports
import libs.API.Utils;
import libs.MainExecuteDB;
import libs.OrderEngine.OrderEngine;


public bool Execute( int argc, string args ) modify throws {
	API.VerifyAccount();

	var accountId = API.retrieve( "account_id" );
	var orderId   = API.retrieve( "order_id" );

	return OrderEngine.CancelOrder( accountId, orderId );
}

