package arm;

import peote.net.Remote;
import peote.net.PeoteClient;
import peote.net.Reason;

import arm.RemoteServer;

// ------------------------------------------------------------
// --------------- CLIENT RPC for Peote Net -------------------
// ------------------------------------------------------------
class RemoteClient implements Remote
{
	public var remote = (null : RemoteServerRemoteClient);
	
	public var peoteClient:PeoteClient;
	public var remoteId:Int = 0;
	public var clientRemote(default, null):Array<Dynamic> = null;
	
	public function new(peoteClient:PeoteClient, remoteId:Int, clientRemote:Array<Dynamic>) {
		trace('NEW REMOTE CLIENT - remoteId:$remoteId');
		this.peoteClient = peoteClient;
		this.remoteId = remoteId;
		this.clientRemote = clientRemote;
	}
	
	public inline function remoteIsReady() {
		remote = RemoteServer.getRemoteClient(peoteClient, remoteId);
		//remote.hello();
	}
		
	public inline function disconnect(reason:Reason) {
		trace('Disconnected - reason:$reason');
	}
	
	public inline function error(reason:Reason) {
		trace('Error connection, reason:$reason');
	}
	
	// ------------------------------------------------------------
	// ----- Functions that run on Client and called by Server ----
	// ------------------------------------------------------------
	
	@:remote public function hello():Void {
		trace('"Hello" at Client side');
		//remote.msgAtServer("test", 54321);
	}
	
	@:remote public function msgAtClient(msg:String, value:Int):Void {
		trace('Message at Client side: $msg, value:$value');
	}
	
}
