#!/usr/local/bin/webscript

public void Main(int argc, string args) {
	print( "Testing all scripts..." );

	system( "./loadSession.os" );
	system( "./loginUser.os" );
	system( "./logoutUser.os" );

	system( "./registerUser.os" );
	system( "./updatePassword.os" );
	system( "./updateUser.os" );

	print( "Done... Testing successful." );
}

