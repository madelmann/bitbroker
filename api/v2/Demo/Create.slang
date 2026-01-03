
// Library imports
import libJson.Reader;

// Project imports
import libs.Accounts;
import libs.Database.Tables.Account;


public namespace DemoAPI
{
    public void Create() modify
    {
        try {
            Database.connect();
            Database.begin();

            if ( CreateAccount() ) {
                Json.AddElement( "result", "success" );
            }
            else {
                Json.AddElement( "result", "failed" );
            }

            Database.commit();
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

    private bool CreateAccount() throws
    {
        var account = Accounts.Register();

        Json.AddElement( "account_id", account.Id );
        Json.AddElement( "time", strftime( "%Y-%m-%dT%H:%M:%S" ) );
        Json.AddElement( "source", account.Source );

        return true;
    }
}
