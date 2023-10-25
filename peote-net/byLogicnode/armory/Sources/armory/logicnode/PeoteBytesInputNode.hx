package armory.logicnode;

import peote.io.PeoteBytesInput;

class PeoteBytesInputNode extends LogicNode {

	var peoteBytesInput:PeoteBytesInput;
	
	public var property0:String;  // max chunksize
	public var property1:String;  // endian
	
	public function new(tree:LogicTree) {
		super(tree);
	}
	
	override function get(from:Int):Dynamic {
		if (from == 1) return peoteBytesInput;
		else return peoteBytesInput.bytesLeft();
	}
	
	override function run(from:Int)
	{
		peoteBytesInput = new PeoteBytesInput( inputs[1].get(), Std.parseInt(property0), switch (property1) {case "BigEndian": true; case "LittleEndian": false; default:null; } );
		runOutput(0);
	}
	
}

