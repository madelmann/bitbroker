///////////////////////////////////////////////////////////////////////////////
// Globals

var mCurrentPlugin = {};
var mInitialized = false;

var mPlugin;
var mPluginCSS;
var mPluginHTML;
var mPluginScript;

// Globals
///////////////////////////////////////////////////////////////////////////////

///////////////////////////////////////////////////////////////////////////////
// Event handling

function OnAbort( event )
{
	if ( mPlugin ) {
		mPlugin.OnAbort( event );
	}
}

function OnError( event )
{
	if ( mPlugin ) {
		mPlugin.OnError( event );
	}
}

function OnLoad(event)
{
	// Initializing components
	// {
	// Plugins
	mPluginCSS = document.getElementById( "plugin_css" );
	mPluginHTML = document.getElementById( "plugin_html" );
	mPluginName = document.getElementById( "plugin_name" );
	mPluginScript = document.getElementById( "plugin_script" );
	// }

	var deviceStr = mParameters.get( "device" );
	if ( deviceStr && deviceStr !== "" ) {
		document.getElementById( "clientarea" ).classList.add( "clientarea_" + deviceStr );
		document.getElementById( "header" ).classList.add( "header_" + deviceStr );
		document.getElementById( "Statusbar" ).classList.add( "Statusbar_" + deviceStr );
	}

	window.onpopstate = function( event ) {
		if ( history.state && history.state.id !== null ) {
			mHistory.Go( history.state.id );
		}
	}

	//LoadPluginInto( "header", document.getElementById( "header" ) );
	//LoadPluginInto( "navigation", document.getElementById( "navigation" ) );

	LoadHomePlugin();
}

function OnLoadReady( event )
{
	if ( mPlugin ) {
		mPlugin.OnLoadReady( event );
	}
}

function OnSuccess( event )
{
	if ( mPlugin ) {
		mPlugin.OnError( event );
	}
}

// Event handling
///////////////////////////////////////////////////////////////////////////////

///////////////////////////////////////////////////////////////////////////////
// Body

function GetPluginName()
{
	if ( mPlugin && mPlugin.mPluginName ) {
		return mPlugin.mPluginName;
	}

	return "";
}

function IsPlugin(pluginName)
{
	return pluginName == GetPluginName();
}

function ParseJSON(input, output) {
	try {
		output.message = JSON.parse( input );

		return true;
	}
	catch ( e ) {
		output.message = e.message;
	}

	return false;
}

// Body
///////////////////////////////////////////////////////////////////////////////

///////////////////////////////////////////////////////////////////////////////
// Plugin: Home

function LoadHomePlugin()
{
	UpdateVisitorCounter();

	mInitialized = true;

	mParameters.clear();

/*
	if ( mAccount.IsLoggedIn() ) {
		// since the user is already logged in redirect him to the last plugin he used or to his own profile plugin

		var lastPlugin = mAccount.GetLastPlugin();
		LoadPluginWithHistory( lastPlugin ? lastPlugin : "start" );
	}
	else {
		// the user has to log in first
		LoadPluginWithHistory( "login" );
	}
*/

	LoadPluginWithHistory( "start" );
}

function UpdateVisitorCounter()
{
	mParameters.clear();

	execute( "admin/updateVisitorCounter.os" );
}

// Plugin: Home
///////////////////////////////////////////////////////////////////////////////

///////////////////////////////////////////////////////////////////////////////
// Generic plugin execution

function execute( pluginFunc, callback_success, callback_error, callback_abort )
{
	if ( pluginFunc.length === 0 ) {
		mNotifications.AddErrorMessage( "Failed to execute '" + pluginFunc + "'!" );
		return false;
	}

	var xmlhttp = null;

	if ( window.XMLHttpRequest ) { // code for IE7+, Firefox, Chrome, Opera, Safari
		xmlhttp = new XMLHttpRequest();
	}
	else {  // code for IE6, IE5
		xmlhttp = new ActiveXObject( "Microsoft.XMLHTTP" );
	}

	var pluginURL = __buildPluginURL( pluginFunc, true );

	xmlhttp.addEventListener( "load", callback_success, false );
	xmlhttp.addEventListener( "error", callback_error, false );
	xmlhttp.addEventListener( "abort", callback_abort, false );
	xmlhttp.open( "POST", pluginURL, true );
	xmlhttp.send();

	return true;
}

function __buildPluginURL( pluginFunc, addParameters )
{
	return __buildURL( "plugins/" + pluginFunc, addParameters );
}

function __buildURL( funcName, addParameters )
{
	var paramStr = "";
	var result = funcName;

	if ( addParameters !== false ) {
		for ( var i = 0; i < mParameters.size(); i++ ) {
			paramStr += "&";

			var name = mParameters.at(i).name;
			var value = mParameters.at(i).value;

			paramStr += name + "=" + value;
		}

		if ( paramStr !== "" ) {
			result += "?" + paramStr;
		}
	}

	return result;
}

function __loadPluginCSS( pluginName, target, forceCacheRefresh )
{
	if ( pluginName.length === 0 ) {
		return false;
	}

	var root = target ? target : document.body;

	var pluginURL = __buildPluginURL( pluginName + "/style.css" + (forceCacheRefresh ? "?v=" + new Date().toString() : ""), false );

	var pluginCSS = document.createElement( "link" );
	pluginCSS.setAttribute( "rel", "stylesheet" );
	pluginCSS.setAttribute( "type", "text/css" );
	pluginCSS.setAttribute( "href", pluginURL );
	root.appendChild( pluginCSS );

	return true;
}

function __loadPluginHTML( pluginName, target, forceCacheRefresh )
{
	if ( pluginName.length === 0 ) { 
		document.getElementById( "plugin_html" ).innerHTML = "";
		document.getElementById( "plugin_html" ).style.border = "0px";
		return false;
	}

	var xmlhttp = null;

	if ( window.XMLHttpRequest ) {
		// code for IE7+, Firefox, Chrome, Opera, Safari
		xmlhttp = new XMLHttpRequest();
	}
	else {  // code for IE6, IE5
		xmlhttp = new ActiveXObject( "Microsoft.XMLHTTP" );
	}

	xmlhttp.onreadystatechange = function() {
		if ( xmlhttp.readyState == 4 && xmlhttp.status == 200) {
			if ( !target ) {
				return;
			}

			target.innerHTML = xmlhttp.responseText;
		}
	};

	var pluginURL = __buildPluginURL( pluginName + "/" + (forceCacheRefresh ? "?v=" + new Date().toString() : ""), true );

	xmlhttp.onerror = OnError;
	xmlhttp.onabort = OnAbort;
	xmlhttp.open( "POST", pluginURL, false );
	xmlhttp.send();

	return true;
}

function __loadPluginHelp( pluginName, forceCacheRefresh )
{
	if ( pluginName.length === 0 ) {
		return false;
	}

	var xmlhttp = null;

	if ( window.XMLHttpRequest ) { // code for IE7+, Firefox, Chrome, Opera, Safari
		xmlhttp = new XMLHttpRequest();
	}
	else {  // code for IE6, IE5
		xmlhttp = new ActiveXObject( "Microsoft.XMLHTTP" );
	}

	xmlhttp.onreadystatechange = function() {
		if ( xmlhttp.readyState == 4 && xmlhttp.status == 200 ) {
			document.getElementById( "help" ).innerHTML = xmlhttp.responseText;
		}
	};

	var pluginURL = __buildPluginURL( pluginName + "/help.os" + (forceCacheRefresh ? "?v=" + new Date().toString() : ""), false );

	xmlhttp.open( "POST", pluginURL, false );
	xmlhttp.send();

	return true;
}

function __loadPluginJS( pluginName, target, callback, forceCacheRefresh )
{
	if ( pluginName.length === 0 ) {
		return false;
	}

	var root = target ? target : document.body;

	var pluginURL = __buildPluginURL( pluginName + "/plugin.js" + (forceCacheRefresh ? "?v=" + new Date().toString() : ""), false );

	var pluginJS = document.createElement( "script" );
	pluginJS.onload = pluginJS.onreadystatechange = function() {
		if ( mCurrentPlugin && mCurrentPlugin.OnLoad ) {
			mCurrentPlugin.OnLoad( callback );
			//mPluginName.innerHTML = mCurrentPlugin.mPluginName;		// TODO: remove this before release
			mCurrentPlugin = {};
		}
		//pluginJS.onload = pluginJS.onreadystatechange = null;
	};

	pluginJS.setAttribute( "type", "text/javascript" );
	pluginJS.setAttribute( "src", pluginURL );
	root.appendChild( pluginJS );

	return true;
}

function LoadPlugin( pluginName, callback, forceCacheRefresh )
{
	mNotifications.ClearNotifications();
	//mParameters.add("r", Math.random());	// seed random number to prevent cached xml http requests

	if ( mGlobals.Debug ) {
		var notification = document.createElement( "div" );
		notification.innerHTML += "<p>" + mParameters.toString() + "</p>";
		mPluginHTML.appendChild( notification );
	}

	mPlugin = null;

	forceCacheRefresh = false;

	__loadPluginHTML( pluginName, mPluginHTML, forceCacheRefresh );
	__loadPluginCSS( pluginName, mPluginHTML, forceCacheRefresh );
	__loadPluginJS( pluginName, mPluginHTML, null, forceCacheRefresh );
	__loadPluginHelp( pluginName, forceCacheRefresh );

	if ( callback ) {
		callback();
	}
}

function LoadPluginInto( pluginName, target, immediateCallback, asyncCallback )
{
	__loadPluginHTML( pluginName, target );
	__loadPluginCSS( pluginName, target );
	__loadPluginJS( pluginName, target, asyncCallback) ;

	if ( immediateCallback ) {
		immediateCallback();
	}
}

function LoadPluginWindow( pluginName, callback )
{
	mNotifications.ClearNotifications();
	//mParameters.add("r", Math.random());	// seed random number to prevent cached xml http requests

	if ( mGlobals.Debug ) {
		var notification = document.createElement( "div" );
		notification.innerHTML += "<p>" + mParameters.toString() + "</p>";
		mPluginHTML.appendChild( notification );
	}

	mPlugin = null;

	var pluginURL = __buildPluginURL( pluginName + "/", true );
	window.open( pluginURL, pluginName, 'width=600,height=400' );

	if ( callback ) {
		callback();
	}
}

function LoadPluginWithHistory( pluginName, callback )
{
	mHistory.PushState( pluginName );

	LoadPlugin( pluginName, callback );
}

// Generic plugin execution
///////////////////////////////////////////////////////////////////////////////

