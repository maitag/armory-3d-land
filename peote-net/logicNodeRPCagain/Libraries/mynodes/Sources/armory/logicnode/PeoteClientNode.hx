package armory.logicnode;

import peote.net.PeoteClient;
import peote.net.Remote;
import peote.net.Reason;

import armory.logicnode.PeoteServerNode;

class PeoteClientNode extends LogicNode {

	var peoteClient:PeoteClient;
	var clientRemote:ClientRemote;

	public function new(tree:LogicTree)
	{
		super(tree);
		
		peoteClient = new PeoteClient(
		{
			onEnter: function(client:PeoteClient)
			{
				// trace('onEnterJoint: Joint number ${client.jointNr} entered');
				clientRemote = new ClientRemote(this);
				client.setRemote(clientRemote, 0);  // --> Server's onRemote will be called with remoteId 0
				runOutput(0);
			},
			
			onRemote: function(client:PeoteClient, remoteId:Int)
			{
				// trace('Client onRemote: jointNr:${client.jointNr}, remoteId:$remoteId');
				clientRemote.serverRemoteIsReady(ServerRemote.getRemoteClient(client, remoteId));
			},
			
			onDisconnect: function(client:PeoteClient, reason:Reason)
			{
				// trace('onDisconnect: jointNr=${client.jointNr}');
				runOutput(1);
			},
			
			onError: function(client:PeoteClient, reason:Reason)
			{
				trace('onEnterJointError:$reason');
				runOutput(2);
			}
			
		});		
		
	}

	override function run(from:Int)
	{
		switch(from) {
			case 0:  // enter server
				var host:String = inputs[1].get();
				var port:Int = inputs[2].get();
				var channelName:String = inputs[3].get();
				
				peoteClient.enter(host, port, channelName);
			
			case 4: peoteClient.leave(); // close
		}
		
	}

}


// --------- REMOTE ----------

class ClientRemote implements Remote {
	
	var client:PeoteClientNode;
		
	public var server = (null : ServerRemoteRemoteClient);
	
	public inline function serverRemoteIsReady( server ) {
		this.server = server;
		server.hello();
	}
	
	// ------------------------------------------------------------

	public function new( client:PeoteClientNode ) {		
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




