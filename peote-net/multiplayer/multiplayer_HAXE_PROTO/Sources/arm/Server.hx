package arm;

import haxe.ds.IntMap;

import peote.net.PeoteServer;
import peote.net.Reason;

class Server
{
	public var peoteServer:PeoteServer;
	public var remoteServerMap = new IntMap<RemoteServer>();
	
	public function new(emulateNetwork:Bool = false) 
	{
		peoteServer = new PeoteServer(
		{
			// bandwith simmulation if there is local testing
			offline : emulateNetwork, // emulate network (to test locally without peote-server)
			netLag  : 20, // results in 20 ms per chunk
			netSpeed: 1024 * 1024 * 512, //[512KB] per second
			
			onCreate: function(server:PeoteServer)
			{
				trace('Server onCreate - jointNr:${server.jointNr}');
			},
			
			onUserConnect: function(server:PeoteServer, userId:Int)
			{
				trace('Server onUserConnect - jointNr:${server.jointNr}, userId:$userId');
			},
			
			onRemote: function(server:PeoteServer, userId:Int, remoteId:Int)
			{
				trace('Server onRemote - jointNr:${server.jointNr}, userId:$userId, remoteId:$remoteId');
				// TODO: error if remoteId is not 0
				
				// store a new ServerRemote for each user into Map
				var remoteServer = new RemoteServer(this, userId);
				remoteServerMap.set(userId, remoteServer);
				remoteServer.remoteIsReady(remoteId);
				
				peoteServer.setRemote(userId, remoteServer, 0); // --> Client's onRemote on will be called with remoteId 0				
			},
			
			onUserDisconnect: function(server:PeoteServer, userId:Int, reason:Int)
			{
				var remoteServer = remoteServerMap.get(userId);
				if (remoteServer != null) {
					remoteServerMap.remove(userId);
					for (remoteServer in remoteServerMap) {
						remoteServer.remote.playerLeaves(userId);
					}
				}
				trace('Server onUserDisconnect - jointNr:${server.jointNr}, userId:$userId');
				switch (reason) {
					case Reason.CLOSE:      trace("User leaves channel.");
					case Reason.DISCONNECT: trace("User was disconnected.");
				}
			},
			
			onError: function(server:PeoteServer, userId:Int, reason:Int)
			{
				var remoteServer = remoteServerMap.get(userId);
				if (remoteServer != null) {
					remoteServerMap.remove(userId);
					for (remoteServer in remoteServerMap) {
						remoteServer.remote.playerLeaves(userId);
					}
				}
				trace('Server onError - jointNr:${server.jointNr}, userId:$userId');
				switch(reason) {
					case Reason.DISCONNECT: trace("Can't connect to peote-server.");
					case Reason.CLOSE:      trace("Connection to peote-server is closed.");
					case Reason.ID:         trace("Another channel with same id (or wrong id).");
					case Reason.MAX:        trace("Created to much channels on this server (max is 128).");
					case Reason.MALICIOUS:  trace("Malicious data (by user).");
				}
			}
			
		});		
	}
	
	// ------------ startServer -------------
	public function start(host:String, port:Int, channelName:String) 
	{					
		peoteServer.create(host, port, channelName);		
	}		
}

