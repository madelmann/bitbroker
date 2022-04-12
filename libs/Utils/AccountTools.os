
// library imports
import libJsonBuilder.StructuredBuilder;

// project imports
import libs.Database;
import libs.Session;


public namespace Utils {

	public bool ChangePassword( string identifier, string password ) throws {
		//Database.begin();

		Database.Execute(
			"UPDATE users set password = " + Utils.prepareEncrypt( password ) + " WHERE identifier = '" + identifier + "'"
		);

		//Database.commit();

		return true;
	}

	public bool Login( string username, string password, bool infinity = false ) throws {
		string query = "SELECT * "
					 + "FROM users u "
					 + "LEFT JOIN profiles p ON ( p.identifier = u.identifier ) "
					 + "WHERE username = '" + username + "' AND password = SHA2('" + password + "', 256)";

		var result = Database.Query( query );

		if ( mysql_fetch_row( result ) ) {
			string identifier = mysql_get_field_value( result, "identifier" );
			string username = mysql_get_field_value( result, "username" );

			var session =  new Session( identifier );
			session.setIsInfinite( infinity );
			session.store();

			Json.BeginObject( "data" );
			Json.AddElement( "identifier", identifier );
			Json.AddElement( "sessionID", session.getId() );
			Json.AddElement( "username", username );
			Json.EndObject();
	
			return true;
		}
	
		Json.AddElement( "message", "invalid user or password" );
		return false;
	}

	public bool Logout() throws {
		var session = Utils.GetSession();
		if ( !session ) {
			Json.AddElement( "message", "no session found" );
			return false;
		}

		// delete session
		session.delete();

		return true;
	}

	public bool Register( string username, string password ) throws {
		//Database.begin();

		Database.Execute(
			"INSERT INTO users ( username, password, identifier ) VALUES ( '" + username + "', " + Utils.prepareEncrypt( password ) + ", SHA2( '" + username + "', 256 ) )"
		);

		//Database.commit();

		return true;
	}

}

