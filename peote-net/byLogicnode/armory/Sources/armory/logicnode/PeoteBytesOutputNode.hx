package armory.logicnode;

import peote.io.PeoteBytesOutput;

class PeoteBytesOutputNode extends LogicNode {

	var peoteBytesOutput:PeoteBytesOutput;
	
	public var property0:String;  // max chunksize
	
	public function new(tree:LogicTree) {
		super(tree);
	}
	
	override function get(from:Int):Dynamic {
		return new PeoteBytesOutput( Std.parseInt(property0) );
	}
	
	
}

