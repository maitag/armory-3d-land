package armory.logicnode;

import peote.io.PeoteBytesOutput;

class PeoteBytesOutputWriteNode extends LogicNode {

	public var property0:String;  // type
		
	public function new(tree:LogicTree) {
		super(tree);
	}
	
	override function get(from:Int):Dynamic {
		var peoteBytesOutput:PeoteBytesOutput = inputs[0].get();
	
		switch (property0) 
		{
			case 'String': peoteBytesOutput.writeString(inputs[1].get());
			case 'Int16' : peoteBytesOutput.writeInt16(inputs[1].get());
			default:				
		}
		
		switch (from) {
			case 0: return peoteBytesOutput;
			case 1: return peoteBytesOutput.getBytes();
			default: return null;
		}
	}
	
	
}

