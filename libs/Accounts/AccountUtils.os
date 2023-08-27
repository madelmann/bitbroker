
// library imports
import libJsonBuilder.StructuredBuilder;

// project imports
import libs.Database.Tables.Account;
import libs.Session;


public namespace Accounts {

    public bool Delete( string identifier ) modify throws {
        Database.begin();

        Database.Execute( "UPDATE account
                              SET deleted = SYSTIMESTAMP()
                            WHERE id = '" + identifier + "'" );

        Database.commit();

        return true;
    }

    public TAccountRecord Register() modify throws {
        var result = Database.Query( "SELECT SHA2( NOW(), 256 ) AS account_id" );
        if ( !Database.FetchRow() ) {
            throw "error while creating account";
        }
    
        var account = new TAccountRecord( Database.Handle );
        account.Id     = mysql_get_field_value( result, "account_id" );
        account.Source = getenv( "REMOTE_ADDR" );
        account.insert();

        return account;
    }

}

