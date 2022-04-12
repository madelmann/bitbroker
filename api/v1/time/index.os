#!/usr/local/bin/webscript

// Library imports

// Project imports
import libs.MainProcessJsonDB;


public void Process( int argc, string args ) {
	Json.AddElement( "iso", strftime( "%Y-%m-%dT%H:%M:%S" ) );
	Json.AddElement( "epoch", time() );
}

