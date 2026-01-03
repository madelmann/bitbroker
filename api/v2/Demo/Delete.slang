
// Library imports

// Project imports
import libs.Accounts.AccountUtils;
import libs.API.Utils;


public namespace DemoAPI.AccountAPI
{
    public void Cancel() modify
    {
        try {
            Database.connect();
            Database.begin();

            if ( DeleteAccount() ) {
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

    private bool DeleteAccount() throws
    {
        API.VerifyAccount();

        var accountId = API.retrieve( "account_id" );

        return Accounts.Delete( accountId );
    }
}
