#!/usr/local/bin/webscript

// library imports

// project imports
import libs.Plugins.ExecutePlugin;


private string TABLE const = "user_data";

public object ExecutePlugin {
	public bool Execute( int argc, string args ) modify throws {
		if ( !isSet( "identifier" ) ) {
			Json.AddElement( "message", "identifier missing" );
			return false;
		}

		string identifier = mysql_real_escape_string( Database.Handle, get( "identifier" ) );
		if ( !identifier ) {
			Json.AddElement( "message", "invalid identifier" );
			return false;
		}

		string prename = mysql_real_escape_string( Database.Handle, get( "prename" ) );
		string surname = mysql_real_escape_string( Database.Handle, get( "surname" ) );

		return UpdateUser( identifier, prename, surname );
	}

	private bool SetPrename( string identifier, string value ) throws {
		string query = "UPDATE " + TABLE + " SET prename = '" + value + "' WHERE identifier = '" + identifier + "'";

		int error = mysql_query( Database.Handle, query );
		if ( error ) {
			throw mysql_error( Database.Handle );
		}

		return true;
	}

	private bool SetSurname( string identifier, string value ) throws {
		string query = "UPDATE " + TABLE + " SET surname = '" + value + "' WHERE identifier = '" + identifier + "'";

		int error = mysql_query( Database.Handle, query );
		if ( error ) {
			throw mysql_error( Database.Handle );
		}

		return true;
	}

	private bool UpdateUser( string identifier, string prename, string surname ) throws {
		string query = "UPDATE " + TABLE + " SET prename = '" + prename + "', surname = '" + surname + "' WHERE identifier = '" + identifier + "'";

		int error = mysql_query( Database.Handle, query );
		if ( error ) {
			throw mysql_error( Database.Handle );
		}

		return true;
	}

}

