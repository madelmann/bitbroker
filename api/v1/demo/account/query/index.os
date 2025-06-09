#!/usr/bin/env webscript

// Library imports

// Project imports
import libs.API.Utils;
import libs.Database.Tables.Account;
import libs.MainProcessJsonDB;


public void Process( int argc, string args ) throws {
	var accountId = API.retrieve( "account_id", "" );

	Json.BeginArray( "accounts" );

	if ( accountId ) {
		querySingleAccount( accountId );
	}
	else {
		queryAllAccounts();
	}

	Json.EndArray();
}

private void queryAllAccounts() const throws {
	var collection = new TAccountCollection( Database.Handle );
	collection.loadByQuery( "SELECT * FROM account ORDER BY created ASC" );

	foreach ( TAccountRecord record : collection ) {
		Json.BeginObject();
		Json.AddElement( "account_id", record.Id );
		Json.AddElement( "time", record.Created );
		Json.AddElement( "source", record.Source );
		Json.EndObject();
	}
}

private void querySingleAccount( string accountId ) const throws {
	var collection = new TAccountCollection( Database.Handle );
	collection.loadByQuery( "SELECT * FROM account WHERE id = '" + accountId + "'" );

	foreach ( TAccountRecord record : collection ) {
		Json.BeginObject();
		Json.AddElement( "account_id", record.Id );
		Json.AddElement( "time", record.Created );
		Json.AddElement( "source", record.Source );
		Json.EndObject();
	}
}

