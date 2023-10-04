package armory.logicnode;

import haxe.ds.IntMap;

import peote.net.PeoteServer;
import peote.net.Remote;
import peote.net.Reason;

class PeoteServerNode extends LogicNode {

	var peoteServer:PeoteServer;
	// var serverRemote = new IntMap<ServerRemote>();
	var serverRemote = new IntMap<Dynamic>();
	
	public var property0:String; // RPC class name
	
	var rpc_class:Class<Dynamic>;
	
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
				trace('onCreateJoint: Channel ${server.jointNr} created.');
				runOutput(1);
			},
			
			onUserConnect: function(server:PeoteServer, userNr:Int)
			{
				trace('onUserConnect: jointNr:${server.jointNr}, userNr:$userNr');
				
				// store a new ServerRemote for each user into Map
				// var _serverRemote = new ServerRemote(this, userNr);
				
				var _serverRemote = Type.createInstance(rpc_class, []);

				serverRemote.set(userNr, _serverRemote);
				
				server.setRemote(userNr, _serverRemote, 0); // --> Client's onRemote on will be called with remoteId 0

				eventUserNr = userNr;
				runOutput(2);
			},
			
			onUserDisconnect: function(server:PeoteServer, userNr:Int, reason:Reason)
			{
				trace('onUserDisconnect: jointNr:${server.jointNr}, userNr:$userNr');
				
				eventUserNr = userNr;
				runOutput(3);
			},
			
			onError: function(server:PeoteServer, userNr:Int, reason:Reason)
			{
				trace('onCreateJointError:$reason, userNr:$userNr');
				
				eventUserNr = userNr;
				runOutput(4);
			},
			
			onRemote: function(server:PeoteServer, userNr:Int, remoteId:Int)
			{
				trace('Server onRemote: jointNr:${server.jointNr}, userNr:$userNr, remoteId:$remoteId');
				
				// TODO:
				serverRemote.get(userNr).remoteIsReady( peoteServer, userNr, remoteId );

				eventUserNr = userNr;
				eventRemoteID = remoteId;
				runOutput(6);
			}
			
		});
	}
	
	var eventUserNr:Int = 0;
	var eventRemoteID:Int = 0;
	override function get(from:Int):Dynamic
	{
		switch (from) {
			case 0: return peoteServer;
			case 5: return eventUserNr;
			case 7: return eventRemoteID;
			default: return null;
		}
	}
	
	override function run(from:Int)
	{
		var emulateNetwork:Bool = inputs[1].get();
		var host:String = inputs[2].get();
		var port:Int = inputs[3].get();
		var channelName:String = inputs[4].get();
		
		peoteServer.offline = emulateNetwork;
		
		rpc_class = Type.resolveClass(Main.projectPackage + "." + property0);
		if (rpc_class == null) rpc_class = Type.resolveClass(Main.projectPackage + ".node." + property0);
		if (rpc_class == null) throw 'No class with the name "${Main.projectPackage + ".(node.)" + property0}" found!';

		
		peoteServer.create(host, port, channelName); // connect
	}
}

