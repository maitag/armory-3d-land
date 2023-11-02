package armory.logicnode;

import haxe.ds.IntMap;
import haxe.io.Bytes;

import peote.net.PeoteServer;
import peote.net.Remote;
import peote.net.Reason;

class PeoteServerNode extends LogicNode {

	var peoteServer:PeoteServer;
	
	public var serverRemote(default, null) = new IntMap<Array<Dynamic>>();
	
	public var property0:String; // onData, onDataChunk, RPC
	public var property1:String;  // max chunksize
	
	var rpc_classes:Array<Class<Dynamic>>;
	var eventUserId:Int = 0;
	var eventRemoteID:Int = 0;
	var bytes:Bytes = null;
	
	public function new(tree:LogicTree) {
		super(tree);
	}
	
	override function get(from:Int):Dynamic {
		switch (from) {
			case 0: return peoteServer;
			case 5: return eventUserId;
			case 7: return (property0 == "RPC") ? eventRemoteID : bytes;
			case 8: return serverRemote;
			default: return null;
		}
	}
	
	override function run(from:Int)
	{
		var emulateNetwork:Bool = inputs[1].get();
		var host:String = inputs[2].get();
		var port:Int = inputs[3].get();
		var channelName:String = inputs[4].get();
		
		switch (property0) 
		{
			case "onData": // -------- using Data handler -----------
			
			peoteServer = new PeoteServer(
			{
				// bandwith simmulation if there is local testing
				offline : emulateNetwork, // emulate network (to test locally without peote-server)
				netLag  : 20, // results in 20 ms per chunk
				netSpeed: 1024 * 1024 * 512, //[512KB] per second
				
				maxBytesPerChunkSize: Std.parseInt(property1),
				
				onCreate: function(peoteServer:PeoteServer) {
					trace('Server onCreateJoint: Channel ${peoteServer.jointNr} created.');
					runOutput(1);
				},				
				onUserConnect: function(peoteServer:PeoteServer, userId:Int) {
					trace('Server onUserConnect: jointNr:${peoteServer.jointNr}, userId:$userId');
					eventUserId = userId;
					runOutput(2);
				},
				onData: function(peoteServer:PeoteServer, userId:Int, bytes:Bytes) {
					trace('Server onData: jointNr:${peoteServer.jointNr}, userId:$userId');					
					eventUserId = userId;
					this.bytes = bytes;
					runOutput(6);
				},
				onUserDisconnect: function(peoteServer:PeoteServer, userId:Int, reason:Reason) {
					trace('Server onUserDisconnect: jointNr:${peoteServer.jointNr}, userId:$userId');
					eventUserId = userId;
					runOutput(3);
				},				
				onError: function(peoteServer:PeoteServer, userId:Int, reason:Reason) {
					trace('Server onCreateJointError:$reason, userId:$userId');
					eventUserId = userId;
					runOutput(4);
				}
			});
			
			case "onDataChunk": // -------- using DataChunk handler -----------
			
			peoteServer = new PeoteServer(
			{
				// bandwith simmulation if there is local testing
				offline : emulateNetwork, // emulate network (to test locally without peote-server)
				netLag  : 20, // results in 20 ms per chunk
				netSpeed: 1024 * 1024 * 512, //[512KB] per second
				
				maxBytesPerChunkSize: Std.parseInt(property1),
				
				onCreate: function(peoteServer:PeoteServer) {
					trace('Server onCreateJoint: Channel ${peoteServer.jointNr} created.');
					runOutput(1);
				},				
				onUserConnect: function(peoteServer:PeoteServer, userId:Int) {
					trace('Server onUserConnect: jointNr:${peoteServer.jointNr}, userId:$userId');
					eventUserId = userId;
					runOutput(2);
				},
				onDataChunk: function(peoteServer:PeoteServer, userId:Int, bytes:Bytes) {
					trace('Server onDataChunk: jointNr:${peoteServer.jointNr}, userId:$userId');					
					eventUserId = userId;
					this.bytes = bytes;
					runOutput(6);
				},
				onUserDisconnect: function(peoteServer:PeoteServer, userId:Int, reason:Reason) {
					trace('Server onUserDisconnect: jointNr:${peoteServer.jointNr}, userId:$userId');
					eventUserId = userId;
					runOutput(3);
				},				
				onError: function(peoteServer:PeoteServer, userId:Int, reason:Reason) {
					trace('Server onCreateJointError:$reason, userId:$userId');
					eventUserId = userId;
					runOutput(4);
				}
			});
			
			case "RPC":  //  ------------- using RPC -------------
			
			var rpc_input_array:Array<String> = inputs[5].get();
			if (rpc_input_array == null || rpc_input_array.length == 0) throw '"Server Remote Classnames"-inputsocket needs to be an String-Array with at least one haxe RemoteClass name';

			rpc_classes = new Array<Class<Dynamic>>();
			
			for (rpc_string in rpc_input_array) {
				var rpc_class = Type.resolveClass(Main.projectPackage + "." + rpc_string);
				if (rpc_class == null) rpc_class = Type.resolveClass(Main.projectPackage + ".node." + rpc_string);
				if (rpc_class == null) throw 'No class with the name "${Main.projectPackage}.(node.)$rpc_string" found!';
				rpc_classes.push(rpc_class);
			}
			
			peoteServer = new PeoteServer(
			{
				// bandwith simmulation if there is local testing
				offline : emulateNetwork, // emulate network (to test locally without peote-server)
				netLag  : 20, // results in 20 ms per chunk
				netSpeed: 1024 * 1024 * 512, //[512KB] per second
				
				onCreate: function(peoteServer:PeoteServer) {
					trace('Server onCreateJoint: Channel ${peoteServer.jointNr} created.');
					runOutput(1);
				},				
				onUserConnect: function(peoteServer:PeoteServer, userId:Int) {
					trace('Server onUserConnect: jointNr:${peoteServer.jointNr}, userId:$userId');
					var rpc_instance_array = new Array<Dynamic>();					
					var i:Int = 0;
					for (rpc_class in rpc_classes) {
						var rpc_instance = Type.createInstance(rpc_class, [peoteServer, userId, i]);
						// trace("class name", Type.getClassName(Type.getClass(_serverRemote)) );
						// trace("fields", Type.getInstanceFields(Type.getClass(_serverRemote)) );
						rpc_instance_array.push(rpc_instance);
						peoteServer.setRemote(userId, rpc_instance, i); // --> Client's onRemote on will be called with remoteId i
						i++;
					}
					serverRemote.set(userId, rpc_instance_array);					
					eventUserId = userId;
					runOutput(2);
				},
				onRemote: function(peoteServer:PeoteServer, userId:Int, remoteId:Int) {
					trace('Server onRemote: jointNr:${peoteServer.jointNr}, userId:$userId, remoteId:$remoteId');
					serverRemote.get(userId)[remoteId].remoteIsReady( peoteServer, userId );
					eventUserId = userId;
					eventRemoteID = remoteId;
					runOutput(6);
				},
				onUserDisconnect: function(peoteServer:PeoteServer, userId:Int, reason:Reason) {
					trace('Server onUserDisconnect: jointNr:${peoteServer.jointNr}, userId:$userId');
					for (rpc_instance in serverRemote.get(userId)) rpc_instance.disconnect(reason);
					eventUserId = userId;
					runOutput(3);
				},				
				onError: function(peoteServer:PeoteServer, userId:Int, reason:Reason) {
					trace('Server onCreateJointError:$reason, userId:$userId');
					for (rpc_instance in serverRemote.get(userId)) rpc_instance.error(reason);
					eventUserId = userId;
					runOutput(4);
				}
			});
			
			default:
		}
		
		peoteServer.create(host, port, channelName); // connect
	}
	
}

