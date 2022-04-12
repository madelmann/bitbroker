
// library imports

// project imports
import Database;
import Database.Views.VSessions;


public object Session {
// Public

	public int DEFAULT_SESSION_LENGTH const = 10 /*minutes*/;

	public static Session load( string sessionID ) modify throws {
		string query = "SELECT * FROM v_sessions WHERE id = '" + sessionID + "' AND (expires = 0 OR expires > NOW())";

		try {
			var s = new VSessionsRecord( Database.Handle, query );

			var session = new Session();
			session.mId = s.Id;
			session.mIsInfinite = !s.Expires;
			session.mIsValid = true;
			session.mUserIdentifier = s.Identifier;

			return session;
		}

		return Session null;
	}

	/*
	 * Default constructor
	 */
	public void Constructor() {
		// nothing to do here
	}

	/*
	 * Explicit constructor
	 */
	public void Constructor( string userIdentifier ) {
		mIsInfinite = false;
		mUserIdentifier = userIdentifier;
	}

	public bool allowCreateUsers() const {
		return mAllowCreateUsers;
	}

	public bool allowDeleteUsers() const {
		return mAllowDeleteUsers;
	}

	public bool allowUpdateUsers() const {
		return mAllowUpdateUsers;
	}

	public void delete() modify throws {
		if ( !mId ) {
			// cannot delete an unset session id
			return;
		}

		string query = "DELETE FROM sessions WHERE id = '" + mId + "'";

		int error = mysql_query( Database.Handle, query );
		if ( error ) {
			throw mysql_error( Database.Handle );
		}
	}

	public void extendValidity( int minutes = 0 ) modify throws {
		if ( !minutes ) {
			minutes = DEFAULT_SESSION_LENGTH;
		}

		string query = "UPDATE sessions SET expires = (NOW() + INTERVAL " + minutes + " MINUTE) WHERE id = '" + mId + "'";

		int error = mysql_query( Database.Handle, query );
		if ( error ) {
			throw mysql_error( Database.Handle );
		}
	}

	public string getId() const {
		return mId;
	}

	public string getUserIdentifier() const {
		return mUserIdentifier;
	}

	public bool isValid() const {
		return mIsValid;
	}

	public void setIsInfinite( bool state ) modify {
		mIsInfinite = state;
	}

	public bool store() modify throws {
		mId = fetchId();

		string query = "INSERT INTO sessions( id, identifier, expires ) " 
			     + "VALUES ( '" + mId + "', '" + mUserIdentifier + "', " + ( mIsInfinite ? "0" : "( NOW() + INTERVAL " + DEFAULT_SESSION_LENGTH + " MINUTE )" ) + " )";

		int error = mysql_query( Database.Handle, query );
		if ( error ) {
			throw mysql_error( Database.Handle );
		}

		return true;
	}

	public string toString() const {
        return "Session { "
                + "mAllowCreateUsers: " + mAllowCreateUsers
                + ", mAllowDeleteUsers: " + mAllowDeleteUsers
                + ", mAllowUpdateUsers: " + mAllowUpdateUsers
                + ", mIsInfinite: " + mIsInfinite
                + ", mIsValid: " + mIsValid
                + ", mSessionId: " + mId
                + ", mUserIdentifier: " + mUserIdentifier
                + " }";
    }
    
// Private

	private string fetchId() const throws {
		string query = "SELECT CreateSessionId( '" + mUserIdentifier + "' ) AS id";

		int error = mysql_query( Database.Handle, query );
		if ( error ) {
			throw mysql_error( Database.Handle );
		}

		int result = mysql_store_result( Database.Handle );

		if ( mysql_fetch_row( result ) ) {
			return mysql_get_field_value( result, "id" );
		}

		throw "no mysql result found!";
	}

	private bool mAllowCreateUsers;
	private bool mAllowDeleteUsers;
	private bool mAllowUpdateUsers;
	private string mId;
	private bool mIsInfinite;
	private bool mIsValid;
	private string mUserIdentifier;
}
