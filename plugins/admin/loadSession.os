#!/usr/local/bin/webscript

// library imports

// project imports
import libs.Plugins.ExecutePlugin;
import libs.Utils.SessionTools;


public object ExecutePlugin {
	public bool Execute( int argc, string args ) modify throws {
		if ( !isSet( "sessionID" ) ) {
			Json.AddElement( "message", "no session provided" );
			return false;
		}

		string sessionID = mysql_real_escape_string( Database.Handle, get( "sessionID" ) );
		if ( !sessionID ) {
			Json.AddElement( "message", "invalid sessionID set" );
			return false;
		}

		return Utils.ReincarnateSession( sessionID );
	}
}

