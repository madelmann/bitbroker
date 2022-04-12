#!/usr/local/bin/webscript

// library imports

// project imports
import libs.Plugins.ExecutePlugin;
import libs.Utils.AccountTools;


public object ExecutePlugin {
	public bool Execute( int argc, string args ) modify throws {
		if ( !isSet( "username" ) || !isSet( "password" ) ) {
			Json.AddElement( "message", "no user or password provided" );
			return false;
		}

		string username = mysql_real_escape_string( Database.Handle, get( "username" ) );
		if ( !username ) {
			Json.AddElement( "message", "invalid username set" );
			return false;
		}

		string password = mysql_real_escape_string( Database.Handle, get( "password" ) );
		if ( !password ) {
			Json.AddElement( "message", "invalid password set" );
			return false;
		}

		bool infinity;
		if ( isSet( "infinity" ) ) {
			infinity = true;
		}

		return Utils.Login( username, password, infinity );
	}
}

