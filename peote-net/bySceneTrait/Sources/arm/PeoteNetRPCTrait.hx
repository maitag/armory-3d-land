package arm;

import haxe.io.Bytes;
import haxe.ds.IntMap;
import peote.net.PeoteServer;
import peote.net.PeoteClient;
import peote.net.Remote;
import peote.net.Reason;

class PeoteNetRPCTrait extends iron.Trait {
	
	var host:String = "maitag.de";
	var port:Int = 7680;
	var channelName:String = "armory-test";
	
	#if !html5
	var emulateNetwork = true;
	#else
	var emulateNetwork = false;
	#end
	
	public var peoteServer:PeoteServer;
	public var peoteClient:PeoteClient;
	
	public function new() {
		super();

		notifyOnInit(function() {
			trace("PeoteNetRPCTrait init");
			
			var server = new Server(host, port, channelName, emulateNetwork);
			var client = new Client(host, port, channelName);
			
		});

		// notifyOnUpdate(function() {
		// });

		// notifyOnRemove(function() {
		// });
	}
	
	
}




// --------------------------------------
// ----------- Server Class -------------
// --------------------------------------
class Server
{
	var peoteServer:PeoteServer;
	var serverRemote = new IntMap<ServerRemote>();

	public function new(host:String, port:Int, channelName:String, emulateNetwork:Bool = false) 
	{
		peoteServer = new PeoteServer(
		{
			// bandwith simmulation if there is local testing
			offline : emulateNetwork, // emulate network (to test locally without peote-server)
			netLag  : 10, // results in 20 ms per chunk
			netSpeed: 1024 * 1024 * 512, //[512KB] per second
			
			onCreate: function(server:PeoteServer)
			{
				trace('onCreateJoint: Channel ${server.jointNr} created.');
			},
			
			onUserConnect: function(server:PeoteServer, userNr:Int)
			{
				trace('onUserConnect: jointNr:${server.jointNr}, userNr:$userNr');
				
				// store a new ServerRemote for each user into Map
				var _serverRemote = new ServerRemote(this, userNr);
				serverRemote.set(userNr, _serverRemote);
				
				server.setRemote(userNr, _serverRemote, 0); // --> Client's onRemote on will be called with remoteId 0				
			},
			
			onRemote: function(server:PeoteServer, userNr:Int, remoteId:Int)
			{
				trace('Server onRemote: jointNr:${server.jointNr}, userNr:$userNr, remoteId:$remoteId');
				serverRemote.get(userNr).clientRemoteIsReady( ClientRemote.getRemoteServer(server, userNr, remoteId) );
			},
			
			onUserDisconnect: function(server:PeoteServer, userNr:Int, reason:Int)
			{
				trace('onUserDisconnect: jointNr:${server.jointNr}, userNr:$userNr');
				//serverRemote.get(userNr) = null;
			},
			
			onError: function(server:PeoteServer, userNr:Int, reason:Int)
			{
				trace('onCreateJointError:$reason, userNr:$userNr');
				//serverRemote.get(userNr) = null;
			}
			
		});
				
		// create server
		peoteServer.create(host, port, channelName);		
	}	

}

// --------- REMOTE ----------

class ServerRemote implements Remote {
	
	var server:Server;
	var userNr:Int;
	
	var client = (null : ClientRemoteRemoteServer);
	
	public inline function clientRemoteIsReady( client ) {
		this.client = client;
		client.hello();
	}
	
	// ------------------------------------------------------------

	public function new( server:Server, userNr:Int) {
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


// --------------------------------------
// ---------- CLIENT Class --------------
// --------------------------------------
class Client {
	
	var peoteClient:PeoteClient;
	var clientRemote:ClientRemote;
	
	public function new(host:String, port:Int, channelName:String) 
	{
		peoteClient = new PeoteClient(
		{
			onEnter: function(client:PeoteClient)
			{
				trace('onEnterJoint: Joint number ${client.jointNr} entered');
				clientRemote = new ClientRemote(this);
				client.setRemote(clientRemote, 0);  // --> Server's onRemote will be called with remoteId 0
			},
			
			onRemote: function(client:PeoteClient, remoteId:Int)
			{
				trace('Client onRemote: jointNr:${client.jointNr}, remoteId:$remoteId');
				clientRemote.serverRemoteIsReady(ServerRemote.getRemoteClient(client, remoteId));
			},
			
			onDisconnect: function(client:PeoteClient, reason:Int)
			{
				trace('onDisconnect: jointNr=${client.jointNr}');
			},
			
			onError: function(client:PeoteClient, reason:Int)
			{
				trace('onEnterJointError:$reason');
			}
			
		});		
		
		// enter server
		peoteClient.enter(host, port, channelName);
	}

}

// --------- REMOTE ----------

class ClientRemote implements Remote {
	
	var client:Client;
		
	public var server = (null : ServerRemoteRemoteClient);
	
	public inline function serverRemoteIsReady( server ) {
		this.server = server;
		server.hello();
	}
	
	// ------------------------------------------------------------

	public function new( client:Client ) {		
		this.client = client;				
	}
	
	
	// ------------------------------------------------------------
	// ----- Functions that run on Client and called by Server ----
	// ------------------------------------------------------------
	
	@:remote public function hello():Void {
		trace('Hello from server');		
		if (server != null) server.message("good morning server");
	}

	@:remote public function message(msg:String):Void {
		trace('Message from server: $msg');
	}

}