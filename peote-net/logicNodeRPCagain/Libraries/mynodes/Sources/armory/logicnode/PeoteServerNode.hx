package armory.logicnode;

import haxe.ds.IntMap;

import peote.net.PeoteServer;
import peote.net.Remote;
import peote.net.Reason;

import armory.logicnode.PeoteClientNode;

class PeoteServerNode extends LogicNode {

	var peoteServer:PeoteServer;
	
	var serverRemote = new IntMap<ServerRemote>();

	public function new(tree:LogicTree)
	{
		super(tree);
		
		
		peoteServer = new PeoteServer(
		{
			// bandwith simmulation if there is local testing
			offline : true, // emulate network (to test locally without peote-server)
			netLag  : 10, // results in 20 ms per chunk
			netSpeed: 1024 * 1024 * 512, //[512KB] per second
			
			onCreate: function(server:PeoteServer)
			{
				// trace('onCreateJoint: Channel ${server.jointNr} created.');
				runOutput(0);
			},
			
			onUserConnect: function(server:PeoteServer, userNr:Int)
			{
				// trace('onUserConnect: jointNr:${server.jointNr}, userNr:$userNr');
				
				// store a new ServerRemote for each user into Map
				var _serverRemote = new ServerRemote(this, userNr);
				serverRemote.set(userNr, _serverRemote);
				
				server.setRemote(userNr, _serverRemote, 0); // --> Client's onRemote on will be called with remoteId 0
				
				eventUserNr = userNr;
				runOutput(1);
			},
			
			onRemote: function(server:PeoteServer, userNr:Int, remoteId:Int)
			{
				// trace('Server onRemote: jointNr:${server.jointNr}, userNr:$userNr, remoteId:$remoteId');
				
				// TODO:
				serverRemote.get(userNr).clientRemoteIsReady( ClientRemote.getRemoteServer(server, userNr, remoteId) );
			},
			
			onUserDisconnect: function(server:PeoteServer, userNr:Int, reason:Reason)
			{
				// trace('onUserDisconnect: jointNr:${server.jointNr}, userNr:$userNr');
				//serverRemote.get(userNr) = null;
				eventUserNr = userNr;
				runOutput(2);
			},
			
			onError: function(server:PeoteServer, userNr:Int, reason:Reason)
			{
				trace('onCreateJointError:$reason, userNr:$userNr');
				//serverRemote.get(userNr) = null;
				eventUserNr = userNr;
				runOutput(3);
			}
			
		});
	}
	
 	var eventUserNr:Int = 0;
	override function get(from:Int):Int {
		switch (from) {
			case 4: return eventUserNr;
			default: return null;
		}
	}

	override function run(from:Int) {
		
		switch(from) {
			case 0:
				var host:String = inputs[1].get();
				var port:Int = inputs[2].get();
				var channelName:String = inputs[3].get();
				
				peoteServer.offline = inputs[4].get();
				
				peoteServer.create(host, port, channelName); // connect
			
			case 5: peoteServer.delete(); // close
			default:
		}
	}
}



// --------- REMOTE ----------

class ServerRemote implements Remote {
	
	var server:PeoteServerNode;
	var userNr:Int;
	
	var client = (null : ClientRemoteRemoteServer);
	
	public inline function clientRemoteIsReady( client ) {
		this.client = client;
		client.hello();
	}
	
	// ------------------------------------------------------------

	public function new( server:PeoteServerNode, userNr:Int) {
		this.server = server;
		this.userNr = userNr;
	}
	
	
	// ------------------------------------------------------------
	// ----- Functions that run on Server and called by Client ----
	// ------------------------------------------------------------
	
	@:remote public function hello():Void {
		trace('Hello from client $userNr');		
		if (client != null) client.message("good morning client");
	}

	@:remote public function message(msg:String):Void {
		trace('Message from client $userNr: $msg');
	}

}

