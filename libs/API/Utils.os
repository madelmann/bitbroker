
// Library imports

// Project imports
import libs.Database.Utils;


public namespace API {

    public void require( string key ) throws {
        if ( !isSet( key ) ) {
            throw "missing " + key;
        }
    }

    public string retrieve( string key ) throws {
        if ( isSet( key ) ) {
            return mysql_real_escape_string( Database.Handle, get( key ) );
        }

        throw "missing " + key;
    }

    public bool retrieve( string key, bool defaultValue ) {
        if ( isSet( key ) ) {
            return cast<bool>( mysql_real_escape_string( Database.Handle, get( key ) ) );
        }

        return defaultValue;
    }

    public double retrieve( string key, double defaultValue ) {
        if ( isSet( key ) ) {
            return cast<double>( mysql_real_escape_string( Database.Handle, get( key ) ) );
        }

        return defaultValue;
    }

    public float retrieve( string key, float defaultValue ) {
        if ( isSet( key ) ) {
            return cast<float>( mysql_real_escape_string( Database.Handle, get( key ) ) );
        }

        return defaultValue;
    }

    public int retrieve( string key, int defaultValue ) {
        if ( isSet( key ) ) {
            return cast<int>( mysql_real_escape_string( Database.Handle, get( key ) ) );
        }

        return defaultValue;
    }

    public string retrieve( string key, string defaultValue ) {
        if ( isSet( key ) ) {
            return mysql_real_escape_string( Database.Handle, get( key ) );
        }

        return defaultValue;
    }

/*
    public bool VerifyApiKey() throws {
        require( "api_key" );
        require( "identifier" );

        var apiKey     = retrieve( "api_key" );
        var identifier = retrieve( "identifier" );

        Database.Query( "SELECT * FROM user_data WHERE api_key = '" + apiKey + "' AND identifier = '" + identifier + "'" );
        if ( !Database.FetchRow() ) {
            throw "api key verification failed!";
        }

        return true;
    }
*/

    public bool VerifyAccount() throws {
        require( "account_id" );

        var accountId = retrieve( "account_id" );

        var result = Database.Query( "SELECT id FROM account WHERE id = '" + accountId + "'" );
        if ( !Database.FetchRow() ) {
            throw "account verification failed!";
        }

        return true;
    }
}

