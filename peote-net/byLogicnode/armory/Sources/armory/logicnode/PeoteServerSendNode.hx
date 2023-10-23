package armory.logicnode;

import peote.net.PeoteServer;

class PeoteServerSendNode extends LogicNode {

	public function new(tree:LogicTree) {
		super(tree);
	}
	
	override function run(from:Int)
	{
		var peoteServer:PeoteServer = inputs[1].get();
		
		if (peoteServer.isRemote) throw("Error, can't send data to Server into RPC mode");
		
		if (peoteServer.isChunks) peoteServer.sendChunk(inputs[2].get(), inputs[3].get());
		else peoteServer.send(inputs[2].get(), inputs[3].get());
		
		runOutput(0);
	}
	
}

