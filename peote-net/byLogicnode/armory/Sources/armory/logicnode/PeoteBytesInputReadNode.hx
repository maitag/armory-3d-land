package armory.logicnode;

import iron.math.Vec4;
import iron.math.Quat;

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
			case 'String'  : value = peoteBytesInput.readString();
			case 'Int8'    : value = peoteBytesInput.readInt8();
			case 'Int16'   : value = peoteBytesInput.readInt16();
			case 'Int24'   : value = peoteBytesInput.readInt24();
			case 'Int32'   : value = peoteBytesInput.readInt32();
			case 'UInt8'   : value = peoteBytesInput.readByte();
			case 'UInt16'  : value = peoteBytesInput.readUInt16();
			case 'UInt24'  : value = peoteBytesInput.readUInt24();
			case 'Bool'    : value = peoteBytesInput.readBool();
			case 'Float'   : value = peoteBytesInput.readFloat();
			case 'Vector'  : value = new Vec4(); value.x = peoteBytesInput.readFloat(); value.y = peoteBytesInput.readFloat(); value.z = peoteBytesInput.readFloat();
			case 'Rotation': value = new Quat(); value.x = peoteBytesInput.readFloat(); value.y = peoteBytesInput.readFloat(); value.z = peoteBytesInput.readFloat(); value.w = peoteBytesInput.readFloat();
			case 'Color'   : value = new Vec4(); value.x = peoteBytesInput.readFloat(); value.y = peoteBytesInput.readFloat(); value.z = peoteBytesInput.readFloat(); value.w = peoteBytesInput.readFloat();
			case 'Bytes'   : value = peoteBytesInput.read();
			default:
		}
		runOutput(0);
	}
	
}

