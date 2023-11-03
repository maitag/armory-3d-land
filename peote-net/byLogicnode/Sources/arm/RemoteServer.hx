package arm;

import peote.net.Remote;
import peote.net.PeoteServer;
import peote.net.Reason;

import arm.RemoteClient;

// ------------------------------------------------------------
// --------------- SERVER RPC for Peote Net -------------------
// ------------------------------------------------------------
class RemoteServer implements Remote
{	
	public var remote = (null : RemoteClientRemoteServer);
	
	public var peoteServer:PeoteServer;
	public var remoteId:Int = 0;
	public var userId:Int = 0;
	
	public function new(peoteServer:PeoteServer, userId:Int, remoteId:Int) {
		trace('NEW REMOTE SERVER - userId:$userId, remoteId:$remoteId');
		this.peoteServer = peoteServer;
		this.userId = userId;
		this.remoteId = remoteId;
	}
	
	public inline function remoteIsReady() {
		remote = RemoteClient.getRemoteServer(peoteServer, userId, remoteId);
		//remote.hello();
	}
	
	public inline function disconnect(reason:Reason) {
		trace('Disconnect user $userId - reason:$reason');
	}
	
	public inline function error(reason:Reason) {
		trace('Error by user $userId connection - reason:$reason');
	}
	
	// ------------------------------------------------------------
	// ----- Functions that run on Server and called by Client ----
	// ------------------------------------------------------------
	
	@:remote public function hello():Void {
		trace('"Hello" at Server side');
		//remote.msgAtClient("test", 12345);
	}
	
	@:remote public function msgAtServer(msg:String, value:Int):Void {
		trace('Message at Server side: $msg, value:$value');
	}
	
}
