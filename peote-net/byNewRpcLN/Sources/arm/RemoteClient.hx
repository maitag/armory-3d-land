package arm;

import peote.net.Remote;
import peote.net.PeoteClient;

import arm.RemoteServer;

class RemoteClient implements Remote {
	public function new() {
		trace("NEW REMOTE CLIENT");
	}
	
	// ------------------------------------------------------------
	// ----------------- RPC for Peote Net ------------------------
	// ------------------------------------------------------------
	public var remote = (null : RemoteServerRemoteClient);
	
	public inline function remoteIsReady( peoteClient:PeoteClient, remoteId:Int ) {
		remote = RemoteServer.getRemoteClient(peoteClient, remoteId);
		remote.hello();
	}
		
	// ------------------------------------------------------------
	// ----- Functions that run on Client and called by Server ----
	// ------------------------------------------------------------
	
	@:remote public function hello():Void {
		trace('Hello');		
		// if (remote != null) remote.message("good morning");
	}
	
}
