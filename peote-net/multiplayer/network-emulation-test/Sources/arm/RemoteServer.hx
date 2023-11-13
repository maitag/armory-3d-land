package arm;

import haxe.ds.IntMap;
import peote.net.Remote;
import peote.net.PeoteServer;
import peote.net.Reason;

//import peote.io.

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
	public var serverRemote:IntMap<Array<Dynamic>> = null;
	
	public function new(peoteServer:PeoteServer, userId:Int, remoteId:Int, serverRemote:IntMap<Array<Dynamic>>) {
		trace('NEW REMOTE SERVER - userId:$userId, remoteId:$remoteId');
		this.peoteServer = peoteServer;
		this.userId = userId;
		this.remoteId = remoteId;
		this.serverRemote = serverRemote;
	}
	
	public inline function remoteIsReady() {
		remote = RemoteClient.getRemoteServer(peoteServer, userId, remoteId);
		for (key => value in serverRemote)
		{
			var remoteServer:RemoteServer = value[remoteId];
			if (remoteServer.remote != null && userId != key ) {
				remoteServer.remote.playerEnters(userId);
				remote.playerEnters(key);
			}
		}
	}
	
	public inline function disconnect(reason:Reason) {
		trace('Disconnect user $userId - reason:$reason');
		for (key => value in serverRemote)
		{
			var remoteServer:RemoteServer = value[remoteId];
			if (remoteServer.remote != null && userId != key ) {
				remoteServer.remote.playerLeaves(userId);
			}
		}
	}
	
	public inline function error(reason:Reason) {
		trace('Error by user $userId connection - reason:$reason');
	}
	
	// ------------------------------------------------------------
	
	public function sendLocRotToOtherConnectedClients(x:Float, y:Float, z:Float, rx:Float, ry:Float, rz:Float) {
		//trace('----- sendLocRotToOtherConnetedClients -----');
		for (key => value in serverRemote)
		{
			var remoteServer:RemoteServer = value[remoteId];
			if (remoteServer.remote != null && userId != key ) {
				remoteServer.remote.playerUpdate(userId, x, y, z, rx, ry, rz);
			}
		}
		
	}
	
	// only if not into emulation mode
	@:access(peote.net.PeoteServer, peote.net.PeoteJointSocket)
	public function debugDataInput() {
		trace(peoteServer.peoteJointSocket.input_end);
	}
		
	
	// ------------------------------------------------------------
	// ----- Functions that run on Server and called by Client ----
	// ------------------------------------------------------------
	
	
	var lastRecieveTime:Float = haxe.Timer.stamp();
	var clientTicksBeforeSend:Int = 4;
	
	@:remote public function updateLocRot(x:Float, y:Float, z:Float, rx:Float, ry:Float, rz:Float):Void {
		
		//debugDataInput(); // only if not into emulation mode
		
		var recievedDeltaTime = haxe.Timer.stamp() - lastRecieveTime;
		lastRecieveTime = haxe.Timer.stamp();

		if (recievedDeltaTime < 0.08) {
			clientTicksBeforeSend++;
			trace('reduce client speed to $clientTicksBeforeSend');
			remote.setTicksBeforeSend(clientTicksBeforeSend);
		}
		
		sendLocRotToOtherConnectedClients(x, y, z, rx, ry, rz);
		
	}
	
	
}
