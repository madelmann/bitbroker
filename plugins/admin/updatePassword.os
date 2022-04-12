#!/usr/local/bin/webscript

// library imports

// project imports
import libs.Plugins.ExecutePlugin;
import libs.Utils.AccountTools;


public object ExecutePlugin {
	public bool Execute( int argc, string args ) modify throws {
		if ( !isSet( "identifier" ) ) {
			throw "identifier missing";
		}
		if ( !isSet( "password" ) ) {
			throw "password missing";
		}

		string identifier = mysql_real_escape_string( Database.Handle, get( "identifier" ) );
		if ( !identifier ) {
			throw "invalid identifier";
		}

		string password = mysql_real_escape_string( Database.Handle, get( "password" ) );
		if ( !password ) {
			throw "invalid password";
		}

		return Utils.ChangePassword( identifier, password );
	}

}

