package armory.logicnode;

import peote.net.PeoteServer;

class PeoteServerCloseNode extends LogicNode {

	public function new(tree:LogicTree) {
		super(tree);
	}
	
	override function run(from:Int)
	{
		var peoteServer:PeoteServer = inputs[1].get();		
		peoteServer.delete();		
		runOutput(0);
	}
	
}

