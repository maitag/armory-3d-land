package arm;

import peote.net.Remote;
import peote.net.PeoteServer;

import arm.RemoteClient;

class RemoteServer implements Remote {
	public function new() {
		trace("NEW REMOTE SERVER");
	}
	
	// ------------------------------------------------------------
	// ----------------- RPC for Peote Net ------------------------
	// ------------------------------------------------------------
	public var remote = (null : RemoteClientRemoteServer);
	
	public inline function remoteIsReady( peoteServer:PeoteServer, userNr:Int, remoteId:Int ) {
		remote = RemoteClient.getRemoteServer(peoteServer, userNr, remoteId);
		remote.hello();
	}
	
	// ------------------------------------------------------------
	// ----- Functions that run on Server and called by Client ----
	// ------------------------------------------------------------
	
	@:remote public function hello():Void {
		trace('Hello');		
		// if (remote != null) remote.message("good morning");
	}
	
}
