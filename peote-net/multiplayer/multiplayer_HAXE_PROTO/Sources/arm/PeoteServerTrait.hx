package arm;

import arm.Server;

class PeoteServerTrait extends iron.Trait {
	
	var host:String = "localhost";
	var port:Int = 7680;
	var channelName:String = "armory-multiplayer";
	
	#if (html5 || hashlink)
	var emulateNetwork = false;
	#else
	var emulateNetwork = true;
	#end
	
	public function new() {
		super();

		notifyOnInit(function() {
			trace("PeoteServerTrait init");
			
			var server = new Server(emulateNetwork);
			server.start(host, port, channelName);
			
		});

		// notifyOnUpdate(function() {
		// });
		// notifyOnRemove(function() {
		// });
	}
	
}
