package arm.node;

@:access(armory.logicnode.LogicNode)@:keep class NetControl extends armory.logicnode.LogicTree {

	var functionNodes:Map<String, armory.logicnode.FunctionNode>;

	var functionOutputNodes:Map<String, armory.logicnode.FunctionOutputNode>;

	public function new() {
		super();
		name = "NetControl";
		this.functionNodes = new Map();
		this.functionOutputNodes = new Map();
		notifyOnAdd(add);
	}

	override public function add() {
		var _Keyboard_001 = new armory.logicnode.MergedKeyboardNode(this);
		_Keyboard_001.property0 = "released";
		_Keyboard_001.property1 = "c";
		_Keyboard_001.preallocInputs(0);
		_Keyboard_001.preallocOutputs(2);
		armory.logicnode.LogicNode.addLink(_Keyboard_001, new armory.logicnode.NullNode(this), 0, 0);
		armory.logicnode.LogicNode.addLink(_Keyboard_001, new armory.logicnode.BooleanNode(this, false), 1, 0);
		var _Keyboard = new armory.logicnode.MergedKeyboardNode(this);
		_Keyboard.property0 = "released";
		_Keyboard.property1 = "s";
		_Keyboard.preallocInputs(0);
		_Keyboard.preallocOutputs(2);
		armory.logicnode.LogicNode.addLink(_Keyboard, new armory.logicnode.NullNode(this), 0, 0);
		armory.logicnode.LogicNode.addLink(_Keyboard, new armory.logicnode.BooleanNode(this, false), 1, 0);
	}
}