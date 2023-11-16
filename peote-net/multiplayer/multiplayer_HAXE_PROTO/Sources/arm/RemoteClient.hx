package arm;

import peote.net.Remote;
import peote.io.Byte;

// --------------------------------------------
#if !peoteDedicatedServer

import iron.Trait;
import iron.math.Vec4;
import iron.object.Object;

import arm.RemoteServer;

class RemoteClient implements Remote
{
	public var remote = (null : RemoteServerRemoteClient);	
	public var client:Client;
	
	public function new(client:Client) {
		trace('NEW REMOTE CLIENT');
		this.client = client;
	}
	
	public inline function remoteIsReady(remoteId:Int) {
		remote = RemoteServer.getRemoteClient(client.peoteClient, remoteId);
		remote.hello();
	}
		
	// ------------------------------------------------------------
	
	public var object(default, set):Object = null;
	function set_object(o:Object):Object {
		trait = o.getTrait(Type.resolveClass(Main.projectPackage + ".node.NetworkClient"));
		lastLoc.setFrom(o.transform.loc);
		lastRot.setFrom(o.children[1].transform.rot.getEuler());
		return object = o;
	}
	
	var trait:Trait; // to call "functions" fron logicnode-trait
	
	var lastLoc:Vec4 = new Vec4();
	var lastRot:Vec4 = new Vec4();
	var sendItNext:Bool = false;
	
	public function onLateUpdate() 
	{
		if (!lastLoc.almostEquals(object.transform.loc, 0.01) ) {
			lastLoc.setFrom(object.transform.loc);
			lastRot.setFrom(object.children[1].transform.rot.getEuler());
			sendItNext = true;
		}
		updatePositionOnTime();
	}
	
	var lastUpdateTicks:Int = 0;
	var ticksBeforeSend:Int= 4;
	
	inline function updatePositionOnTime() {		
		if (sendItNext && lastUpdateTicks >= ticksBeforeSend) {
			
			// send position to server
			remote.updateLocRot(lastLoc.x, lastLoc.y, lastLoc.z, lastRot.x, lastRot.y, lastRot.z);
			
			lastUpdateTicks = 0;
			sendItNext = false;
		}
		else lastUpdateTicks++;
		
	}
	
	// ------------------------------------------------------------
	// ----- Functions that run on Client and called by Server ----
	// ------------------------------------------------------------
	
	@remote public function setTicksBeforeSend(ticks:Byte) {
		ticksBeforeSend = ticks;
		// TODO: try to find best value here to not allways speed down!
		// e.g. after some time try to increase the speed!
	}
	
	
	@remote public function playerEnters(playerId:Int)
	{
		//trace('user ${object.uid}: $playerId enters');
		//if (object.properties.get("secondPlayer")) {}
		//var trait = object.getTrait(Type.resolveClass(Main.projectPackage + ".node.NetworkClient"));
		Reflect.callMethod(trait, Reflect.field(trait, "playerEnters"), [playerId]);
		
		//update position one time so all others get them
		remote.updateLocRot(lastLoc.x, lastLoc.y, lastLoc.z, lastRot.x, lastRot.y, lastRot.z);
		lastUpdateTicks = 0;
	}
	
	@remote public function playerLeaves(playerId:Int) 
	{
		//trace('user ${object.uid}: $playerId leaves');
		Reflect.callMethod(trait, Reflect.field(trait, "playerLeaves"), [playerId]);		
	}
	
	@remote public function playerUpdate(playerId:Int, x:Float, y:Float, z:Float, rx:Float, ry:Float, rz:Float)
	{
		// trace('user ${object.uid}: playerUpdate $playerId');
		Reflect.callMethod(trait, Reflect.field(trait, "playerUpdate"), [playerId, x, y, z, rx, ry, rz]);
	}

	
	
	// ------------------------------------------------------------
	
	@:remote public function hello():Void {
		trace('Hello from server');		
	}

	@:remote public function message(msg:String):Void {
		trace('Message from server: $msg');
		if (remote != null) remote.message("good morning server");
	}

}

#else

// ------------------------------------------------------------
//     for more easy building dedicated Server out of armory
// ------------------------------------------------------------

class RemoteClient implements Remote
{
	@remote public function setTicksBeforeSend(ticks:Byte) {}
	@remote public function playerEnters(playerId:Int) {}
	@remote public function playerLeaves(playerId:Int) {}
	@remote public function playerUpdate(playerId:Int, x:Float, y:Float, z:Float, rx:Float, ry:Float, rz:Float) {}
	@:remote public function hello():Void {}
	@:remote public function message(msg:String):Void {}
}
#end