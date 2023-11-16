package arm;

import arm.Client;

class PeoteClientTrait extends iron.Trait {
	
	var host:String = "localhost";
	var port:Int = 7680;
	var channelName:String = "armory-multiplayer";
		
	public function new() {
		super();

		notifyOnInit(function() {
			trace("PeoteClientTrait init");
			
			var client = new Client();
			//haxe.Timer.delay( ()->{ client.start(host, port, channelName); }, 2000);
			client.start(host, port, channelName);
			
		});

		// notifyOnUpdate(function() {
		// });
		// notifyOnRemove(function() {
		// });
	}
	
	
}
