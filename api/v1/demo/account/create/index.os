#!/usr/local/bin/webscript

// Library imports

// Project imports
import libs.Database.Tables.Account;
import libs.Database.Utils;
import libs.MainProcessJsonDB;


public void Process( int argc, string args ) throws {

	int result = Database.Query( "SELECT SHA2( NOW(), 256 ) AS account_id" );
	if ( !mysql_fetch_row( result ) ) {
		throw "error while creating account";
	}

	var account = new TAccountRecord( Database.Handle );
	account.Id = mysql_get_field_value( result, "account_id" );
	account.Source = getenv( "REMOTE_ADDR" );
	account.insert();

	Json.AddElement( "account_id", account.Id );
	Json.AddElement( "time", strftime( "%Y-%m-%dT%H:%M:%S" ) );
	Json.AddElement( "source", account.Source );
}

