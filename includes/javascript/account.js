
mAccount = {

OnAbort: function(event) {
	// request execution aborted
	alert( "OnAbort: " + event.currentTarget.responseText );
},

OnError: function(event) {
	// request execution failed
	alert( "OnError: " + event.currentTarget.responseText );
},

OnLoginSuccess: function( event ) {
	// request execution was successful

	var response = {};
	if ( ParseJSON( event.currentTarget.responseText, response ) ) {
		// json string has been parsed successfully
		if ( response.message.result == "success" ) {
			mAccount.SetLogin( response.message.data );

			if ( mCallbackSuccess ) {
				mCallbackSuccess();
			}
		}
		else {
			LoadPlugin( "login" );

			if ( mCallbackFailed ) {
				mCallbackFailed( response.message.message );
			}
		}
	}
	else {
		// error while parsing json string
		alert( "Error: " + event.currentTarget.responseText );
	}

	mCallbackFailed = null;
	mCallbackSuccess = null;
},

OnRegisterSuccess: function( event ) {
	// request execution was successful

	var response = {};
	if ( ParseJSON( event.currentTarget.responseText, response ) ) {
		// json string has been parsed successfully
		if ( response.message.result == "success" ) {
			if ( mCallbackSuccess ) {
				mCallbackSuccess();
			}
		}
		else if ( mCallbackFailed ) {
			mCallbackFailed( response.message.message );
		}
	}
	else {
		// error while parsing json string
		alert( "Error: " + event.currentTarget.responseText );
	}

	mCallbackFailed = null;
	mCallbackSuccess = null;
},

OnSuccess: function(event) {
	// request execution was successful

	var response = {};
	if ( ParseJSON( event.currentTarget.responseText, response ) ) {
		// json string has been parsed successfully
		if ( response.message.result == "success" ) {
			mAccount.SetLogin( response.message.data );

			if ( mCallbackSuccess ) {
				mCallbackSuccess();
			}
		}
		else if ( mCallbackFailed ) {
			mCallbackFailed( response.message.message );
		}
	}
	else {
		// error while parsing json string
		alert( "Error: " + event.currentTarget.responseText );
	}

	mCallbackFailed = null;
	mCallbackSuccess = null;
},

OnUpdateSuccess: function( event ) {
	var response = {};
	if ( ParseJSON( event.currentTarget.responseText, response ) ) {
		// json string has been parsed successfully
		if ( response.message.result == "success" ) {
			if ( mCallbackSuccess ) {
				mCallbackSuccess();
			}
		}
		else if ( mCallbackFailed ) {
			mCallbackFailed( response.message.message );
		}
	}
	else {
		// error while parsing json string
		alert( "Error: " + event.currentTarget.responseText );
	}

	mCallbackFailed = null;
	mCallbackSuccess = null;
},

Constructor: function() {
	mCallbackFailed = null;
	mCallbackSuccess = null;
	mElLoginLabel = null;
	mIdentifier = localStorage.getItem( "identifier" );
	mIsAdmin = false;
	mSessionId = localStorage.getItem( "sessionID" );

	if ( mIdentifier && mSessionId ) {
		mParameters.addOrSetPermanent( "identifier", mIdentifier );
		mParameters.addOrSetPermanent( "sessionID", mSessionId );

		this.ReloadSession( mIdentifier, mSessionId );
	}
},

Destructor: function() {
},

GetIdentifier: function() {
	return mIdentifier;
},

GetLastPlugin: function() {
	return localStorage.getItem( "lastPlugin" );
},

GetSessionId: function() {
	return mSessionId;
},

IsAdmin: function() {
	return mIsAdmin == true || mIsAdmin == "1";
},

IsLoggedIn: function() {
	return mIdentifier && mSessionId;
},

Login: function( username, password, callbackSuccess, callbackFailed ) {
	mCallbackSuccess = callbackSuccess;
	mCallbackFailed = callbackFailed;

	mParameters.clear();
	mParameters.add("username", username);
	mParameters.add("password", password);

	execute("admin/loginUser.os", this.OnLoginSuccess, this.OnError, this.OnAbort);
},

Logout: function( callbackSuccess ) {
	if ( mElLoginLabel ) {
		mElLoginLabel.textContent = "Login";
	}

	mCallbackFailed = null;
	mCallbackSuccess = callbackSuccess;

	mIdentifier = null;
	mIsAdmin = false;
	mSessionId = null;

	localStorage.removeItem( "identifier" );
	localStorage.removeItem( "lastPlugin" );
	localStorage.removeItem( "sessionID" );

	execute( "admin/logoutUser.os" );

	mParameters.removePermanent( "identifier" );
	mParameters.removePermanent( "sessionID" );

	if ( callbackSuccess ) {
		callbackSuccess();
	}
},

needsStartScreen: function() {
	return !mAccount.IsLoggedIn();
},

Register: function( username, password, callbackSuccess, callbackFailed ) {
	mCallbackFailed = callbackFailed
	mCallbackSuccess = callbackSuccess;

	mParameters.clear();
	mParameters.add( "username", username );
	mParameters.add( "password", password );

	execute( "admin/registerUser.os", this.OnRegisterSuccess, this.OnError, this.OnAbort );
},

ReloadSession: function( identifier, sessionID ) {
	mParameters.clear();
	mParameters.addOrSet( "identifier", identifier );
	mParameters.addOrSet( "sessionID", sessionID );

	execute( "admin/loadSession.os", this.OnSuccess, this.OnError, this.OnAbort );
},

SetCurrentPlugin: function( pluginName ) {
	localStorage.setItem( "lastPlugin", pluginName );
},

SetLogin: function( data ) {
	if ( !mElLoginLabel ) {
		mElLoginLabel = document.getElementById( "login_label" );
	}

	if ( mElLoginLabel ) {
		mElLoginLabel.textContent = username;
	}

	mIdentifier = data.identifier;
	mSessionId = data.sessionID;

	localStorage.setItem( "identifier", mIdentifier );
	localStorage.setItem( "sessionID", mSessionId );

	mParameters.addOrSetPermanent( "identifier", mIdentifier );
	mParameters.addOrSetPermanent( "sessionID", mSessionId );
},

UpdatePassword: function( identifier, password, callbackSuccess, callbackFailed ) {
	if ( !identifier ) {
		if ( callbackFailed ) {
			callbackFailed( "invalid identifier" );
			return;
		}
	}

	mCallbackSuccess = callbackSuccess;
	mCallbackFailed = callbackFailed;

	mParameters.clear();
	mParameters.add( "password", password );

	execute( "admin/updatePassword.os", this.OnUpdateSuccess, this.OnError, this.OnAbort );
},

UpdateUser: function( identifier, prename, surname, callbackSuccess, callbackFailed ) {
	if ( !identifier ) {
		if ( callbackFailed ) {
			callbackFailed("invalid identifier");
			return;
		}
	}

	mCallbackSuccess = callbackSuccess;
	mCallbackFailed = callbackFailed;

	mParameters.clear();
	mParameters.add( "prename", prename );
	mParameters.add( "surname", surname );

	execute( "admin/updateUser.os", this.OnUpdateSuccess, this.OnError, this.OnAbort );
}

}

