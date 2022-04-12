#!/usr/local/bin/webscript

// library imports

// project imports
import libs.Plugins.ExecutePlugin;
import libs.Utils.AccountTools;


public object ExecutePlugin {
	public bool Execute( int argc, string args ) modify throws {
		return Utils.Logout();
	}
}
