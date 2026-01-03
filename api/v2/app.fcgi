#!/usr/bin/env -S slang-app --verbose

// Library imports
import libJsonBuilder;
import libCurl;

// Project imports
import libs.API;
import libs.Database.Utils;
import Demo;
import Private;
import Public;


public void Main( int argc, string args )
{
}

public void Default()
{
	print( "Cryptofox API v2:" );
	print( "=================" );
	print( "" );
	print( "- ping" );
	DemoAPI.Default();
	PrivateAPI.Default();
	PublicAPI.Default();
	print( "- time" );
}

public void Ping()
{
	Json.AddElement( "result", "pong" );

	print( Json.GetString() );
}

public void Time()
{
	Json.AddElement( "iso", strftime( "%Y-%m-%dT%H:%M:%S" ) );
	Json.AddElement( "epoch", time() );

	print( Json.GetString() );
}

