package arm;

import peote.net.PeoteClient;
import peote.net.Reason;

class Client
{
	public var peoteClient:PeoteClient;
	public var remoteClient:RemoteClient = null;
	
	public function new()
	{
		peoteClient = new PeoteClient(
		{
			onEnter: function(client:PeoteClient)
			{
				trace('Client onEnter - jointNr:${client.jointNr}');
				remoteClient = new RemoteClient(this);
				peoteClient.setRemote(remoteClient, 0);  // --> Server's onRemote will be called with remoteId 0
			},
			
			onRemote: function(client:PeoteClient, remoteId:Int)
			{
				trace('Client onRemote - jointNr:${client.jointNr}, remoteId:$remoteId');
				// TODO: error if remoteId is not 0
				remoteClient.remoteIsReady(remoteId);
			},
			
			onDisconnect: function(client:PeoteClient, reason:Int)
			{
				remoteClient = null;
				trace('Client onDisconnect - jointNr:${client.jointNr}');
				switch (reason) {
					case Reason.CLOSE:      trace("Channel closed by creator.");
					case Reason.DISCONNECT: trace("Channel-creator disconnected.");
				}
			},
			
			onError: function(client:PeoteClient, reason:Int)
			{
				remoteClient = null;
				trace('Client onError - jointNr:${client.jointNr}');
				switch(reason) {
					case Reason.DISCONNECT:trace("can't connect to peote-server");
					case Reason.CLOSE:     trace("disconnected from peote-server");
					case Reason.ID:        trace("No channel with this ID to enter.");
					case Reason.MAX:       trace("Entered to much channels on this server (max is 128)");
					case Reason.FULL:      trace("Channel is full (max of 256 users already connected).");
					case Reason.MALICIOUS: trace("Malicious data.");
				}
			}
			
		});		
		
	}
	
	// ----------- startClient --------------
	public function start(host:String, port:Int, channelName:String) 
	{
		peoteClient.enter(host, port, channelName);
	}
	
}
