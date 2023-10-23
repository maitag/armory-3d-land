package armory.logicnode;

import peote.net.PeoteClient;

class PeoteClientSendNode extends LogicNode {

	public function new(tree:LogicTree) {
		super(tree);
	}
	
	override function run(from:Int)
	{
		var peoteClient:PeoteClient = inputs[1].get();
		
		if (peoteClient.isRemote) throw("Error, can't send data to Client into RPC mode");
		
		if (peoteClient.isChunks) peoteClient.sendChunk(inputs[2].get());
		else peoteClient.send(inputs[2].get());
		
		runOutput(0);
	}
	
}

