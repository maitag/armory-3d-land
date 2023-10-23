package armory.logicnode;

import peote.net.PeoteClient;

class PeoteClientCloseNode extends LogicNode {

	public function new(tree:LogicTree) {
		super(tree);
	}
	
	override function run(from:Int)
	{
		var peoteClient:PeoteClient = inputs[1].get();		
		peoteClient.leave();		
		runOutput(0);
	}
	
}

