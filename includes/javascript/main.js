
// Initial member declarations
var mAccount;
var mGlobals = {};
var mHeader;
var mHelp;
var mHistory;
var mNotifications;
var mParameters;
var mProfile;
var mSettings;

function Initialize()
{
	mGlobals.Admin = false;
	mGlobals.Debug = false;

	mHelp.Constructor();
	mHistory.Constructor();
	mNotifications.Constructor();
	mParameters.Constructor();
	mSettings.Constructor();

	// determine storage capabilities
	if ( typeof(Storage) !== "undefined" ) {
		// Code for localStorage/sessionStorage.
		mGlobals.StorageAvailable = true;

		mAccount.Constructor();
	}
	else {
		// Sorry! No Web Storage support..
		mGlobals.StorageAvailable = false;
	}
}

function Shutdown()
{
	mAccount.Destructor();
	mHelp.Destructor();
	mHistory.Destructor();
	mNotifications.Destructor();
	mParameters.Destructor();
	mSettings.Destructor();
}

function sleep(delay) {
	var start = new Date().getTime();

	while ( new Date().getTime() < start + delay ) ;
}

