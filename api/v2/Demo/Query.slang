
// Library imports

// Project imports
import libs.Database.Tables.Account;


public namespace DemoAPI
{
    public void Query() modify
    {
        try {
            Database.connect();

            QueryAccounts();

            Database.disconnect();
        }
        catch ( string e ) {
            Json.AddElement( "message", e );
        }
        catch ( IException e ) {
            Json.AddElement( "message", e.what() );
        }

        API.Response.Finalize();
    }

    private void QueryAccounts() throws
    {
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

    private void queryAllAccounts() const throws
    {
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

    private void querySingleAccount( string accountId ) const throws
    {
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
}
