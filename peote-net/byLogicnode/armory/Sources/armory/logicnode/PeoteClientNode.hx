package armory.logicnode;

import haxe.io.Bytes;

import peote.net.PeoteClient;
import peote.net.Remote;
import peote.net.Reason;

class PeoteClientNode extends LogicNode {

	var peoteClient:PeoteClient;
	
	public var clientRemote(default, null) = new Array<Dynamic>();

	public var property0:String; // onData, onDataChunk, RPC
	public var property1:String; // max chunksize
	
	var eventRemoteID:Int = 0;
	var bytes:Bytes = null;
	
	public function new(tree:LogicTree) {
		super(tree);
	}	
	
	override function get(from:Int):Dynamic {
		switch (from) {
			case 0: return peoteClient;
			case 5: return (property0 == "RPC") ? eventRemoteID : bytes;
			case 6: return clientRemote;
			default: return null;
		}
	}
	
	override function run(from:Int)
	{
		var host:String = inputs[1].get();
		var port:Int = inputs[2].get();
		var channelName:String = inputs[3].get();
		
		switch (property0) 
		{
			case "onData": // -------- using Data handler -----------
			
			peoteClient = new PeoteClient(
			{
				maxBytesPerChunkSize: Std.parseInt(property1),
				
				onEnter: function(peoteClient:PeoteClient) {
					trace('Client onEnterJoint: Joint number ${peoteClient.jointNr} entered');
					runOutput(1);
				},
				onData: function(peoteClient:PeoteClient, bytes:Bytes) {
					this.bytes = bytes;
					trace('Client onData: jointNr:${peoteClient.jointNr}');
					runOutput(4);
				},
				onDisconnect: function(peoteClient:PeoteClient, reason:Reason) {
					trace('Client onDisconnect: jointNr=${peoteClient.jointNr}');
					runOutput(2);
				},
				onError: function(client:PeoteClient, reason:Reason) {
					trace('Client onEnterJointError:$reason');
					runOutput(3);
				}
			});
			
			case "onDataChunk": // -------- using DataChunk handler -----------
			
			peoteClient = new PeoteClient(
			{
				maxBytesPerChunkSize: Std.parseInt(property1),
				
				onEnter: function(peoteClient:PeoteClient) {
					trace('Client onEnterJoint: Joint number ${peoteClient.jointNr} entered');
					runOutput(1);
				},
				onDataChunk: function(peoteClient:PeoteClient, bytes:Bytes) {
					this.bytes = bytes;
					trace('Client onDataChunk: jointNr:${peoteClient.jointNr}');
					runOutput(4);
				},
				onDisconnect: function(peoteClient:PeoteClient, reason:Reason) {
					trace('Client onDisconnect: jointNr=${peoteClient.jointNr}');
					runOutput(2);
				},
				onError: function(client:PeoteClient, reason:Reason) {
					trace('Client onEnterJointError:$reason');
					runOutput(3);
				}
			});
			
			case "RPC":  //  ------------- using RPC -------------
			
			var rpc_input_array:Array<String> = inputs[4].get();
			if (rpc_input_array == null || rpc_input_array.length == 0) throw '"Server Remote Classnames"-inputsocket needs to be an String-Array with at least one haxe RemoteClass name';
			
			peoteClient = new PeoteClient(
			{
				onEnter: function(peoteClient:PeoteClient) {
					trace('Client onEnterJoint: Joint number ${peoteClient.jointNr} entered');
					runOutput(1);
				},
				onRemote: function(peoteClient:PeoteClient, remoteId:Int) {
					trace('Client onRemote: jointNr:${peoteClient.jointNr}, remoteId:$remoteId');
					
					peoteClient.setRemote(clientRemote[remoteId], remoteId);
					clientRemote[remoteId].remoteIsReady();
					
					eventRemoteID = remoteId;
					runOutput(4);
				},
				onDisconnect: function(peoteClient:PeoteClient, reason:Reason) {
					trace('Client onDisconnect: jointNr=${peoteClient.jointNr}');
					for (rpc_instance in clientRemote) rpc_instance.disconnect(reason);
					runOutput(2);
				},
				onError: function(peoteClient:PeoteClient, reason:Reason) {
					trace('Client onEnterJointError:$reason');
					for (rpc_instance in clientRemote) rpc_instance.error(reason);
					runOutput(3);
				}
			});
			
			var i = 0;
			for (rpc_string in rpc_input_array) {
				var rpc_class = Type.resolveClass(Main.projectPackage + "." + rpc_string);
				if (rpc_class == null) rpc_class = Type.resolveClass(Main.projectPackage + ".node." + rpc_string);
				if (rpc_class == null) throw 'No class with the name "${Main.projectPackage}.(node.)$rpc_string" found!';
				clientRemote.push(Type.createInstance(rpc_class, [peoteClient, i]));
				i++;
			}
			
			default:
		}
		
		peoteClient.enter(host, port, channelName); // connect
	}
	
}
