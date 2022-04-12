
// library imports

// project imports


public namespace Utils {

	public bool Debug = false;
	public bool IsAdmin = false;

	public void parseParameters() modify {
		if ( isSet( "admin" ) ) {
			IsAdmin = ( get( "admin" ) == "1" );
		}
		if ( isSet( "debug" ) ) {
			Debug = ( get( "debug" ) == "1" );
		}
	}

	public string prepareEncrypt( string text, int strength = 256 ) const {
		return "SHA2('" + text + "', " + strength + ")";
	}

}

