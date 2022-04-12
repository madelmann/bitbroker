
// library imports
import libJsonBuilder.StructuredBuilder;

// project imports
import libs.Database;
import libs.Session;


public namespace Utils {

public string GetIdentifier() throws {
	return GetSession().getUserIdentifier();
}

public Session GetSession() throws {
	if ( !isSet( "sessionID" ) ) {
		throw "sessionID is missing";
	}

	string sessionID = mysql_real_escape_string( Database.Handle, get( "sessionID" ) );
	if ( !sessionID ) {
		throw "invalid sessionID set";
	}

	return Session.load( sessionID );
}

public bool ReincarnateSession( string sessionID ) throws {
	var session = Session.load( sessionID );
	if ( !session || !session.isValid() ) {
		return false;
	}

	Json.BeginObject( "data" );
	Json.AddElement( "identifier", session.getUserIdentifier() );
	Json.AddElement( "sessionID", sessionID );
	Json.EndObject();

	return true;
}

}

