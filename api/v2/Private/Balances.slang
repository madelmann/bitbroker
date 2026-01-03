
// Library imports

// Project imports
import libs.API.HTTP;
import libs.Database.Tables.Balance;


public namespace PrivateAPI.Balances
{
    public void Query() modify
    {
        try {
            Database.connect();

            QueryBalances();

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

    private void QueryBalances() throws
    {
        API.VerifyAccount();

        var accountId    = API.retrieve( "account_id" );
        var currencyCode = API.retrieve( "currency_code", "" );

        if ( currencyCode ) {
            GetSingleCurrency( accountId, currencyCode );
        }
        else {
            GetAllCurrencies( accountId );
        }
    }

    private void GetAllCurrencies( string accountId ) throws
    {
        var balances = new TBalanceCollection( Database.Handle );
        balances.loadByQuery( "SELECT * FROM balance WHERE account_id = '" + accountId + "'" );

        Json.AddElement( "account_id", accountId );
        Json.BeginArray( "balances" );
        foreach ( TBalanceRecord record : balances ) {
            Json.BeginObject();
            Json.AddElement( "account_id", record.AccountId );
            Json.AddElement( "currency_code", record.CurrencyCode );
            Json.AddElement( "available", record.Available );
            Json.AddElement( "locked", record.Locked );
            Json.AddElement( "time", record.Time );
            Json.EndObject();
        }
        Json.EndArray();
    }

    private void GetSingleCurrency( string accountId, string currencyCode ) throws
    {
        var record = new TBalanceRecord( Database.Handle );
        record.loadByQuery( "SELECT * FROM balance WHERE account_id = '" + accountId + "' AND currency_code = '" + currencyCode + "'" );

        Json.AddElement( "account_id", accountId );
        Json.BeginArray( "balances" );
        Json.BeginObject();
        Json.AddElement( "account_id", record.AccountId );
        Json.AddElement( "currency_code", record.CurrencyCode );
        Json.AddElement( "available", record.Available );
        Json.AddElement( "locked", record.Locked );
        Json.AddElement( "time", record.Time );
        Json.EndObject();
        Json.EndArray();
    }
}
