
// Library imports

// Project imports
import libs.OrderEngine.OrderEngine;


public namespace PrivateAPI.OrderAPI
{
    public void Cancel() modify
    {
        try {
            Database.connect();
            Database.begin();

            if ( CancelOrder() ) {
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

    private bool CancelOrder() modify throws
    {
        API.VerifyAccount();

        var accountId = API.retrieve( "account_id" );
        var orderId   = API.retrieve( "order_id" );

        return OrderEngine.CancelOrder( accountId, orderId );
    }
}
