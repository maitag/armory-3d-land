package arm;

import peote.io.Byte;

import peote.net.Remote;
import arm.RemoteClient;

class RemoteServer implements Remote
{	
	public var remote = (null : RemoteClientRemoteServer);	
	public var server:Server;
	public var userId:Int = 0;
	
	public function new(server:Server, userId:Int) {
		trace('NEW REMOTE SERVER - userId:$userId');
		this.server = server;
		this.userId = userId;
	}
	
	public inline function remoteIsReady(remoteId:Int) {
		remote = RemoteClient.getRemoteServer(server.peoteServer, userId, remoteId);
		remote.hello();
		
		// TODO: better inside spawnPlayer(x, y, z...)
		/*
		for (user => remoteServer in server.remoteServerMap)
		{
			if (remoteServer.remote != null && userId != user ) {
				remoteServer.remote.playerEnters(userId);
				remote.playerEnters(key);
			}
		}
		*/
	}
	
	// ------------------------------------------------------------
	
	public function sendLocRotToOtherConnectedClients(x:Float, y:Float, z:Float, rx:Float, ry:Float, rz:Float) {
		//trace('----- sendLocRotToOtherConnetedClients -----');
		for (user => remoteServer in server.remoteServerMap)
		{
			if (remoteServer.remote != null && userId != user ) {
				remoteServer.remote.playerUpdate(userId, x, y, z, rx, ry, rz);
			}
		}
		
	}
	
	// only if not into emulation mode
	@:access(peote.net.PeoteServer, peote.net.PeoteJointSocket)
	public function debugDataInput() {
		trace(server.peoteServer.peoteJointSocket.input_end);
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
			remote.setTicksBeforeSend((clientTicksBeforeSend:Byte));
		}
		
		sendLocRotToOtherConnectedClients(x, y, z, rx, ry, rz);
		
	}
	
	// ------------------------------------------------------------

	
	@:remote public function hello():Void {
		trace('Hello from client $userId');		
		if (remote != null) remote.message("good morning client");
	}

	@:remote public function message(msg:String):Void {
		trace('Message from client $userId: $msg');
	}
	
}
