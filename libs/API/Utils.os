
// Library imports

// Project imports
import libs.Database.Utils;

public namespace API {
	public bool VerifyAccount() throws {
		if ( !isSet( "account_id" ) ) {
			throw "missing account_id";
		}

		var accountId = mysql_real_escape_string( Database.Handle, get( "account_id" ) );

		int result = Database.Query( "SELECT id FROM account WHERE id = '" + accountId + "'" );
		if ( !mysql_fetch_row( result ) ) {
			throw "account verification failed!";
		}

		return true;
	}
}

