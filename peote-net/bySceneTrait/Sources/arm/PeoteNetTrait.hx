package arm;

import haxe.io.Bytes;
import peote.net.PeoteServer;
import peote.net.PeoteClient;
import peote.net.Reason;
import peote.io.PeoteBytesInput;
import peote.io.PeoteBytesOutput;

class PeoteNetTrait extends iron.Trait {
	
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
			trace("PeoteNetTrait init");
			
			initPeoteServer(emulateNetwork); // websocket not works into krom at now
			peoteServer.create(host, port, channelName);
			
		});

		// notifyOnUpdate(function() {
		// });

		// notifyOnRemove(function() {
		// });
	}
	
	public function initPeoteServer(emulateNetwork = false) 
	{
		peoteServer = new PeoteServer({
			
			offline: emulateNetwork,  // did not open a socket (for testing client-connection inside same app)
			netLag: 400,    // simmulates net response time (in milliseconds)
			netSpeed: 1024, // simmulates net speed (in Bytes per second)			
			
			onCreate: function(server:PeoteServer) {
				trace('Channel ${server.jointNr} created.');
				
				// connect as Client also
				initPeoteClient();
				peoteClient.enter(host, port, channelName);	


			},
			onError: function(server:PeoteServer, userNr:Int, reason:Int) {
				switch(reason) {
					case Reason.DISCONNECT: trace("Can't connect to peote-server.");
					case Reason.CLOSE:      trace("Connection to peote-server is closed.");
					case Reason.ID:         trace("Another channel with same id (or wrong id).");
					case Reason.MAX:        trace("Created to much channels on this server (max is 128).");
					case Reason.MALICIOUS:  trace("Malicious data (by user).");
				}
			},
			onUserConnect: function(server:PeoteServer, userNr:Int) {
				trace('New user $userNr enters channel ${server.jointNr}.');
				
				// send something to client
				var output:PeoteBytesOutput = new PeoteBytesOutput();
				output.writeString('Hello Client $userNr');
				server.sendChunk( userNr, output.getBytes() );
			},
			onUserDisconnect: function(server:PeoteServer, userNr:Int, reason:Int) {
				trace('User $userNr disconnects from channel ${server.jointNr}.');
				switch (reason) {
					case Reason.CLOSE:      trace("User leaves channel.");
					case Reason.DISCONNECT: trace("User was disconnected.");
				}
			},
			//choose between onData or onDataChunk (do not use one for remoteobject functioncalling)
			//onData: function(server:PeoteServer, userNr:Int, bytes:Bytes ) {
			//	trace('User $userNr sends some bytes on channel ${server.jointNr}');
			//},
			onDataChunk: function(server:PeoteServer, userNr:Int, bytes:Bytes) {
				var input = new PeoteBytesInput(bytes);
				trace( input.readString() ); // Hello Server
			},
			// maxChunkSize: 256  // max amount of bytes per chunk (default is 32 KB)
		});
	}
	
	
	public function initPeoteClient() 
	{
		peoteClient = new PeoteClient({
			onEnter: function(client:PeoteClient) {
				trace('Connect: Channel ${client.jointNr} entered');
				
				// send something to server
				var output:PeoteBytesOutput = new PeoteBytesOutput();
				output.writeString("Hello Server");
				client.sendChunk( output.getBytes() );
			},
			onError: function(client:PeoteClient, reason:Int) {
				switch(reason) {
					case Reason.DISCONNECT:trace("can't connect to peote-server");
					case Reason.CLOSE:     trace("disconnected from peote-server");
					case Reason.ID:        trace("No channel with this ID to enter.");
					case Reason.MAX:       trace("Entered to much channels on this server (max is 128)");
					case Reason.FULL:      trace("Channel is full (max of 256 users already connected).");
					case Reason.MALICIOUS: trace("Malicious data.");
				}
			},
			onDisconnect: function(client:PeoteClient, reason:Int) {
				trace('Disconnected from channel ${client.jointNr}');
				switch (reason) {
					case Reason.CLOSE:      trace("Channel closed by creator.");
					case Reason.DISCONNECT: trace("Channel-creator disconnected.");
				}
			},
			//choose between onData or onDataChunk (do not use one for remoteobject functioncalling)
			//onData: function(client:PeoteClient, bytes:Bytes) {
			//	trace('Server sends some bytes on channel ${client.jointNr}');
			//},
			onDataChunk: function(client:PeoteClient, bytes:Bytes) {
				var input = new PeoteBytesInput(bytes);
				trace( input.readString() ); // Hello Client ..
			},
			// maxChunkSize: 256  // max amount of bytes per chunk (default is 32 KB)
		});
	}
	
}
