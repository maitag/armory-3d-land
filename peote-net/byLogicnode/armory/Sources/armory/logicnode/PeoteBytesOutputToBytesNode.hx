package armory.logicnode;

import peote.io.PeoteBytesOutput;

class PeoteBytesOutputToBytesNode extends LogicNode {

	public function new(tree:LogicTree) {
		super(tree);
	}
	
	override function get(from:Int):Dynamic {
		return (inputs[0].get():PeoteBytesOutput).getBytes();
	}
	
	
}

