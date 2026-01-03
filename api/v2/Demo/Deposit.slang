
// Library imports

// Project imports
import libs.Database.Tables.Balance;


public namespace DemoAPI
{
    public void Deposit() modify
    {
        try {
            Database.connect();
            Database.begin();

            if ( DepositQuote() ) {
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

    private bool DepositQuote() throws
    {
        API.VerifyAccount();

        var accountId    = API.retrieve( "account_id" );
        var amount       = cast<double>( API.retrieve( "amount" ) );
        var currencyCode = API.retrieve( "currency_code" );

        var balance = new TBalanceRecord( Database.Handle );
        balance.AccountId = accountId;
        balance.CurrencyCode = currencyCode;
        try {
            balance.loadByQuery( "SELECT * FROM balance WHERE account_id = '" + accountId + "' AND currency_code = '" + currencyCode + "' LIMIT 1" );
        }

        balance.Available += amount;
        balance.insertOrUpdate();

        return true;
    }
}
