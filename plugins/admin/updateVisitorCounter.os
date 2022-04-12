#!/usr/local/bin/webscript

// library imports

// project imports
import libs.Plugins.ExecutePlugin;
import libs.Utils.VisitorCounter;


public object ExecutePlugin {
	public bool Execute( int argc, string args ) modify throws {
		var vc = new VisitorCounter( Database.Handle );
		vc.increment();

		return true;
	}
}

