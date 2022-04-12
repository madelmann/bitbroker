#!/usr/local/bin/webscript

// Library imports

// Project imports
import libs.Database.Utils;
import libs.MainExecuteDB;


public bool Execute( int argc, string args ) throws {
	if ( !isSet( "account_id" ) ) {
		throw "missing account_id";
	}

	var accountId = mysql_real_escape_string( Database.Handle, get( "account_id" ) );

	Database.Execute( "DELETE FROM account WHERE id = '" + accountId + "'" );

	return true;
}

