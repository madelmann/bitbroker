#!/usr/bin/env webscript

// Library imports

// Project imports
import libs.Accounts;
import libs.Database.Tables.Account;
import libs.MainProcessJsonDB;


public void Process( int argc, string args ) throws {
	var account = Accounts.Register();

	Json.AddElement( "account_id", account.Id );
	Json.AddElement( "time", strftime( "%Y-%m-%dT%H:%M:%S" ) );
	Json.AddElement( "source", account.Source );
}

