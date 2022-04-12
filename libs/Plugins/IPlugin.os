
// library imports

// project imports
import libs.Utils.SessionTools;


public interface IPlugin {
}


public interface IExecutePlugin implements IPlugin {
	public bool Execute() modify;
}


public interface IRawPlugin implements IPlugin {
	public void Process() modify;
}


public interface IRenderPlugin implements IPlugin {
	public void Render() modify;
}


public object ASessionPlugin {
	public void Constructor() {
		mSession = Utils.GetSession();
	}

	protected Session mSession;
}

