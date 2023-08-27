#!/usr/local/bin/webscript

// Library imports

// Project imports
import libs.Accounts.AccountUtils;
import libs.API.Utils;
import libs.MainExecuteDB;


public bool Execute( int argc, string args ) throws {
	API.VerifyAccount();

	var accountId = API.retrieve( "account_id" );

	return Accounts.Delete( accountId );
}

