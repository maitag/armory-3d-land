package armory.logicnode;

import peote.net.PeoteClient;
import peote.net.Remote;
import peote.net.Reason;

class PeoteClientNode extends LogicNode {

	var peoteClient:PeoteClient;
	var clientRemote:Dynamic;

	public var property0:String; // RPC class name
	
	var rpc_class:Class<Dynamic>;

	public function new(tree:LogicTree)
	{
		super(tree);
		
		peoteClient = new PeoteClient(
		{
			onEnter: function(client:PeoteClient)
			{
				trace('onEnterJoint: Joint number ${client.jointNr} entered');
				
				//clientRemote = new ClientRemote(this);
				
				clientRemote = Type.createInstance(rpc_class, []);
				
				client.setRemote(clientRemote, 0);  // --> Server's onRemote will be called with remoteId 0
				
				runOutput(1);
			},
			
			onDisconnect: function(client:PeoteClient, reason:Reason)
			{
				trace('onDisconnect: jointNr=${client.jointNr}');
				runOutput(2);
			},
			
			onError: function(client:PeoteClient, reason:Reason)
			{
				trace('onEnterJointError:$reason');
				runOutput(3);
			},
			
			onRemote: function(client:PeoteClient, remoteId:Int)
			{
				trace('Client onRemote: jointNr:${client.jointNr}, remoteId:$remoteId');
				
				clientRemote.remoteIsReady(client, remoteId);

				eventRemoteID = remoteId;				
				runOutput(4);
			}
			
		});		
		
	}
	
	var eventRemoteID:Int = 0;
	override function get(from:Int):Dynamic {
		switch (from) {
			case 0: return peoteClient;
			case 5: return eventRemoteID;
			default: return null;
		}
	}
	
	override function run(from:Int)
	{
		var host:String = inputs[1].get();
		var port:Int = inputs[2].get();
		var channelName:String = inputs[3].get();
		
		rpc_class = Type.resolveClass(Main.projectPackage + "." + property0);
		if (rpc_class == null) rpc_class = Type.resolveClass(Main.projectPackage + ".node." + property0);
		if (rpc_class == null) throw 'No class with the name "${Main.projectPackage + ".(node.)" + property0}" found!';
		
		peoteClient.enter(host, port, channelName);
	}

}
