
// Library imports

// Project imports
import libs.Database.Tables.Balance;


public namespace DemoAPI
{
    public void Withdraw() modify
    {
        try {
            Database.connect();
            Database.begin();

            if ( WithdrawQuote() ) {
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

    private bool WithdrawQuote() throws
    {
        API.VerifyAccount();

        var accountId    = API.retrieve( "account_id" );
        var amount       = cast<double>( API.retrieve( "amount" ) );
        var currencyCode = API.retrieve( "currency_code" );

        var balance = new TBalanceRecord( Database.Handle );
        try {
            balance.loadByQuery( "SELECT * FROM balance WHERE account_id = '" + accountId + "' AND currency_code = '" + currencyCode + "' LIMIT 1" );
        }

        if ( balance.Available < amount ) {
            throw "invalid funds";
        }

        balance.Available -= amount;
        balance.insertOrUpdate();

        return true;
    }
}
