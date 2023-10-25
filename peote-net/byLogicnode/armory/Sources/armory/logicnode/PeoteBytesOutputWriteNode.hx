package armory.logicnode;

import iron.math.Vec4;
import iron.math.Quat;

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
			case 'String'  : peoteBytesOutput.writeString(inputs[1].get());
			case 'Int8'    : peoteBytesOutput.writeInt8(inputs[1].get());
			case 'Int16'   : peoteBytesOutput.writeInt16(inputs[1].get());
			case 'Int24'   : peoteBytesOutput.writeInt24(inputs[1].get());
			case 'Int32'   : peoteBytesOutput.writeInt32(inputs[1].get());
			case 'UInt8'   : peoteBytesOutput.writeByte(inputs[1].get());
			case 'UInt16'  : peoteBytesOutput.writeUInt16(inputs[1].get());
			case 'UInt24'  : peoteBytesOutput.writeUInt24(inputs[1].get());
			case 'Bool'    : peoteBytesOutput.writeBool(inputs[1].get());
			case 'Float'   : peoteBytesOutput.writeFloat(inputs[1].get());
			case 'Vector'  : var v:Vec4 = inputs[1].get(); peoteBytesOutput.writeFloat(v.x); peoteBytesOutput.writeFloat(v.y); peoteBytesOutput.writeFloat(v.z);
			case 'Rotation': var r:Quat = inputs[1].get(); peoteBytesOutput.writeFloat(r.x); peoteBytesOutput.writeFloat(r.y); peoteBytesOutput.writeFloat(r.z); peoteBytesOutput.writeFloat(r.w);
			case 'Color'   : var c:Vec4 = inputs[1].get(); peoteBytesOutput.writeFloat(c.x); peoteBytesOutput.writeFloat(c.y); peoteBytesOutput.writeFloat(c.z); peoteBytesOutput.writeFloat(c.w);
			case 'Bytes'   : peoteBytesOutput.write(inputs[1].get());
			default:
		}
		
		return peoteBytesOutput;
	}
	
	
}

