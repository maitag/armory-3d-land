package arm.node;

@:access(armory.logicnode.LogicNode)@:keep class PlayActions extends armory.logicnode.LogicTree {

	var functionNodes:Map<String, armory.logicnode.FunctionNode>;

	var functionOutputNodes:Map<String, armory.logicnode.FunctionOutputNode>;

	public function new() {
		super();
		name = "PlayActions";
		this.functionNodes = new Map();
		this.functionOutputNodes = new Map();
		notifyOnAdd(add);
	}

	override public function add() {
		var _PlayActionFrom_002 = new armory.logicnode.PlayActionFromNode(this);
		_PlayActionFrom_002.preallocInputs(9);
		_PlayActionFrom_002.preallocOutputs(2);
		var _Keyboard_002 = new armory.logicnode.MergedKeyboardNode(this);
		_Keyboard_002.property0 = "started";
		_Keyboard_002.property1 = "1";
		_Keyboard_002.preallocInputs(0);
		_Keyboard_002.preallocOutputs(2);
		armory.logicnode.LogicNode.addLink(_Keyboard_002, new armory.logicnode.BooleanNode(this, false), 1, 0);
		armory.logicnode.LogicNode.addLink(_Keyboard_002, _PlayActionFrom_002, 0, 0);
		armory.logicnode.LogicNode.addLink(new armory.logicnode.ObjectNode(this, ""), _PlayActionFrom_002, 0, 1);
		armory.logicnode.LogicNode.addLink(new armory.logicnode.StringNode(this, "walk_01"), _PlayActionFrom_002, 0, 2);
		armory.logicnode.LogicNode.addLink(new armory.logicnode.IntegerNode(this, 1), _PlayActionFrom_002, 0, 3);
		armory.logicnode.LogicNode.addLink(new armory.logicnode.IntegerNode(this, 0), _PlayActionFrom_002, 0, 4);
		armory.logicnode.LogicNode.addLink(new armory.logicnode.FloatNode(this, 0.25), _PlayActionFrom_002, 0, 5);
		armory.logicnode.LogicNode.addLink(new armory.logicnode.FloatNode(this, 1.0), _PlayActionFrom_002, 0, 6);
		armory.logicnode.LogicNode.addLink(new armory.logicnode.BooleanNode(this, true), _PlayActionFrom_002, 0, 7);
		armory.logicnode.LogicNode.addLink(new armory.logicnode.BooleanNode(this, false), _PlayActionFrom_002, 0, 8);
		armory.logicnode.LogicNode.addLink(_PlayActionFrom_002, new armory.logicnode.NullNode(this), 0, 0);
		armory.logicnode.LogicNode.addLink(_PlayActionFrom_002, new armory.logicnode.NullNode(this), 1, 0);
		var _Print_002 = new armory.logicnode.PrintNode(this);
		_Print_002.preallocInputs(2);
		_Print_002.preallocOutputs(1);
		var _OnActionMarker_001 = new armory.logicnode.OnActionMarkerNode(this);
		_OnActionMarker_001.preallocInputs(2);
		_OnActionMarker_001.preallocOutputs(1);
		armory.logicnode.LogicNode.addLink(new armory.logicnode.ObjectNode(this, ""), _OnActionMarker_001, 0, 0);
		armory.logicnode.LogicNode.addLink(new armory.logicnode.StringNode(this, "my_marker"), _OnActionMarker_001, 0, 1);
		armory.logicnode.LogicNode.addLink(_OnActionMarker_001, _Print_002, 0, 0);
		var _String_002 = new armory.logicnode.StringNode(this);
		_String_002.preallocInputs(1);
		_String_002.preallocOutputs(1);
		armory.logicnode.LogicNode.addLink(new armory.logicnode.StringNode(this, "marker!"), _String_002, 0, 0);
		armory.logicnode.LogicNode.addLink(_String_002, _Print_002, 0, 1);
		armory.logicnode.LogicNode.addLink(_Print_002, new armory.logicnode.NullNode(this), 0, 0);
		var _SetActionPaused = new armory.logicnode.SetActionPausedNode(this);
		_SetActionPaused.preallocInputs(3);
		_SetActionPaused.preallocOutputs(1);
		var _Keyboard_001 = new armory.logicnode.MergedKeyboardNode(this);
		_Keyboard_001.property0 = "started";
		_Keyboard_001.property1 = "space";
		_Keyboard_001.preallocInputs(0);
		_Keyboard_001.preallocOutputs(2);
		armory.logicnode.LogicNode.addLink(_Keyboard_001, new armory.logicnode.BooleanNode(this, false), 1, 0);
		armory.logicnode.LogicNode.addLink(_Keyboard_001, _SetActionPaused, 0, 0);
		armory.logicnode.LogicNode.addLink(new armory.logicnode.ObjectNode(this, ""), _SetActionPaused, 0, 1);
		var _InvertBoolean = new armory.logicnode.NotNode(this);
		_InvertBoolean.preallocInputs(1);
		_InvertBoolean.preallocOutputs(1);
		var _GetActionState = new armory.logicnode.AnimationStateNode(this);
		_GetActionState.preallocInputs(1);
		_GetActionState.preallocOutputs(3);
		armory.logicnode.LogicNode.addLink(new armory.logicnode.ObjectNode(this, ""), _GetActionState, 0, 0);
		armory.logicnode.LogicNode.addLink(_GetActionState, new armory.logicnode.StringNode(this, ""), 0, 0);
		armory.logicnode.LogicNode.addLink(_GetActionState, new armory.logicnode.IntegerNode(this, 0), 1, 0);
		armory.logicnode.LogicNode.addLink(_GetActionState, _InvertBoolean, 2, 0);
		armory.logicnode.LogicNode.addLink(_InvertBoolean, _SetActionPaused, 0, 2);
		armory.logicnode.LogicNode.addLink(_SetActionPaused, new armory.logicnode.NullNode(this), 0, 0);
	}
}