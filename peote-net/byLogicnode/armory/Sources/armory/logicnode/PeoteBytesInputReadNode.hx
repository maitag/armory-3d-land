package armory.logicnode;

import peote.io.PeoteBytesInput;

class PeoteBytesInputReadNode extends LogicNode {

	public var property0:String;  // type
	
	public function new(tree:LogicTree) {
		super(tree);
	}
	
	var value:Dynamic;
	
	override function get(from:Int):Dynamic {
		return value;
	}
	
	override function run(from:Int)
	{
		var peoteBytesInput:PeoteBytesInput = inputs[1].get();
		switch (property0) 
		{
			case 'String': value = peoteBytesInput.readString();
			case 'Int16': value = peoteBytesInput.readInt16();
			default:				
		}
		runOutput(0);
	}
	
}

