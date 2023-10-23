package armory.logicnode;

import peote.io.PeoteBytesInput;

class PeoteBytesInputNode extends LogicNode {

	var peoteBytesInput:PeoteBytesInput;
	
	public var property0:String;  // max chunksize
	
	public function new(tree:LogicTree) {
		super(tree);
	}
	
	override function get(from:Int):Dynamic {
		return peoteBytesInput;
	}
	
	override function run(from:Int)
	{
		peoteBytesInput = new PeoteBytesInput( inputs[1].get(), Std.parseInt(property0) );
		runOutput(0);
	}
	
}

