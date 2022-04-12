#!/usr/local/bin/webscript

// Library imports

// Project imports
import libs.API.Utils;
import libs.Database.Utils;
import libs.MainExecuteDB;


public bool Execute( int argc, string args ) throws {
	API.VerifyAccount();

	var accountId = API.retrieve( "account_id" );

	Database.Execute( "DELETE FROM account WHERE id = '" + accountId + "'" );

	return true;
}

