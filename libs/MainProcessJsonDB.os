
// library import
import libJsonBuilder.StructuredBuilder;
import System.Exception;

// project imports
import Database;
import Utils;


public void Main( int argc, string args ) modify {
	// HTTP request header
	//print( "== Request ==" );
	//print( "ACCEPT: " + getenv( "ACCEPT" ) );
	//print( "AUTHORIZATION: " + getenv( "AUTHORIZATION" ) );
	//print( "CONTENT_LENGTH: " + getenv( "CONTENT_LENGTH" ) );
	//print( "CONTENT_TYPE: " + getenv( "CONTENT_TYPE" ) );

	try {
		Utils.parseParameters();

		Database.connect();

		Process( argc, args );

		Database.disconnect();
	}
	catch ( string e ) {
		Json.AddElement( "message", e );
	}
	catch ( IException e ) {
		Json.AddElement( "message", e.what() );
	}

	var content = Json.GetString();

	// HTTP response header
	//print( "== Response ==" );
	//print( "CONTENT_TYPE: application/json" ) );
	//print( "CONTENT_LENGTH: " + strlen( content ) ) );

	print( content );
}

