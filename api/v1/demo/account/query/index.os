#!/usr/local/bin/webscript

// Library imports

// Project imports
import libs.Database.Tables.Account;
import libs.MainProcessJsonDB;


public void Process( int argc, string args ) throws {
	var collection = new TAccountCollection( Database.Handle );
	collection.loadByQuery( "SELECT * FROM account ORDER BY created ASC" );

	Json.BeginArray( "accounts" );
	foreach ( TAccountRecord record : collection ) {
		Json.BeginObject();
		Json.AddElement( "account_id", record.Id );
		Json.AddElement( "time", record.Created );
		Json.AddElement( "source", record.Source );
		Json.EndObject();
	}
	Json.EndArray();
}

