package arm.node;

@:access(armory.logicnode.LogicNode)@:keep class CamRotateZoom extends armory.logicnode.LogicTree {

	var functionNodes:Map<String, armory.logicnode.FunctionNode>;

	var functionOutputNodes:Map<String, armory.logicnode.FunctionOutputNode>;

	public function new() {
		super();
		name = "CamRotateZoom";
		this.functionNodes = new Map();
		this.functionOutputNodes = new Map();
		notifyOnAdd(add);
	}

	override public function add() {
		var _SetCursorState_001 = new armory.logicnode.SetCursorStateNode(this);
		_SetCursorState_001.property0 = "hide locked";
		_SetCursorState_001.preallocInputs(2);
		_SetCursorState_001.preallocOutputs(1);
		var _Mouse_001 = new armory.logicnode.MergedMouseNode(this);
		_Mouse_001.property0 = "released";
		_Mouse_001.property1 = "left";
		_Mouse_001.preallocInputs(0);
		_Mouse_001.preallocOutputs(2);
		armory.logicnode.LogicNode.addLink(_Mouse_001, new armory.logicnode.BooleanNode(this, false), 1, 0);
		armory.logicnode.LogicNode.addLink(_Mouse_001, _SetCursorState_001, 0, 0);
		var _InvertBoolean_001 = new armory.logicnode.NotNode(this);
		_InvertBoolean_001.preallocInputs(1);
		_InvertBoolean_001.preallocOutputs(1);
		var _GetCursorState_002 = new armory.logicnode.GetCursorStateNode(this);
		_GetCursorState_002.preallocInputs(0);
		_GetCursorState_002.preallocOutputs(3);
		armory.logicnode.LogicNode.addLink(_GetCursorState_002, new armory.logicnode.BooleanNode(this, false), 1, 0);
		armory.logicnode.LogicNode.addLink(_GetCursorState_002, new armory.logicnode.BooleanNode(this, false), 2, 0);
		armory.logicnode.LogicNode.addLink(_GetCursorState_002, _InvertBoolean_001, 0, 0);
		armory.logicnode.LogicNode.addLink(_InvertBoolean_001, _SetCursorState_001, 0, 1);
		armory.logicnode.LogicNode.addLink(_SetCursorState_001, new armory.logicnode.NullNode(this), 0, 0);
		var _SetVariable = new armory.logicnode.SetVariableNode(this);
		_SetVariable.preallocInputs(3);
		_SetVariable.preallocOutputs(1);
		var _SetVariable_001 = new armory.logicnode.SetVariableNode(this);
		_SetVariable_001.preallocInputs(3);
		_SetVariable_001.preallocOutputs(1);
		var _IsTrue = new armory.logicnode.IsTrueNode(this);
		_IsTrue.preallocInputs(2);
		_IsTrue.preallocOutputs(1);
		var _Mouse = new armory.logicnode.MergedMouseNode(this);
		_Mouse.property0 = "moved";
		_Mouse.property1 = "left";
		_Mouse.preallocInputs(0);
		_Mouse.preallocOutputs(2);
		armory.logicnode.LogicNode.addLink(_Mouse, new armory.logicnode.BooleanNode(this, false), 1, 0);
		armory.logicnode.LogicNode.addLink(_Mouse, _IsTrue, 0, 0);
		var _GetCursorState_001 = new armory.logicnode.GetCursorStateNode(this);
		_GetCursorState_001.preallocInputs(0);
		_GetCursorState_001.preallocOutputs(3);
		armory.logicnode.LogicNode.addLink(_GetCursorState_001, new armory.logicnode.BooleanNode(this, false), 1, 0);
		armory.logicnode.LogicNode.addLink(_GetCursorState_001, new armory.logicnode.BooleanNode(this, false), 2, 0);
		armory.logicnode.LogicNode.addLink(_GetCursorState_001, _IsTrue, 0, 1);
		armory.logicnode.LogicNode.addLink(_IsTrue, _SetVariable_001, 0, 0);
		var _Float = new armory.logicnode.FloatNode(this);
		_Float.preallocInputs(1);
		_Float.preallocOutputs(1);
		armory.logicnode.LogicNode.addLink(new armory.logicnode.FloatNode(this, 0.5), _Float, 0, 0);
		armory.logicnode.LogicNode.addLink(_Float, _SetVariable_001, 0, 1);
		var _Math = new armory.logicnode.MathNode(this);
		_Math.property0 = "Add";
		_Math.property1 = true;
		_Math.preallocInputs(2);
		_Math.preallocOutputs(1);
		armory.logicnode.LogicNode.addLink(_Float, _Math, 0, 0);
		var _GetMouseMovement = new armory.logicnode.GetMouseMovementNode(this);
		_GetMouseMovement.preallocInputs(3);
		_GetMouseMovement.preallocOutputs(6);
		armory.logicnode.LogicNode.addLink(new armory.logicnode.FloatNode(this, -0.0010000000474974513), _GetMouseMovement, 0, 0);
		armory.logicnode.LogicNode.addLink(new armory.logicnode.FloatNode(this, -0.0020000000949949026), _GetMouseMovement, 0, 1);
		armory.logicnode.LogicNode.addLink(new armory.logicnode.FloatNode(this, -1.0), _GetMouseMovement, 0, 2);
		armory.logicnode.LogicNode.addLink(_GetMouseMovement, new armory.logicnode.FloatNode(this, 0.0), 0, 0);
		armory.logicnode.LogicNode.addLink(_GetMouseMovement, new armory.logicnode.FloatNode(this, 0.0), 1, 0);
		armory.logicnode.LogicNode.addLink(_GetMouseMovement, new armory.logicnode.IntegerNode(this, 0), 4, 0);
		armory.logicnode.LogicNode.addLink(_GetMouseMovement, new armory.logicnode.FloatNode(this, 0.0), 5, 0);
		armory.logicnode.LogicNode.addLink(_GetMouseMovement, _Math, 3, 1);
		armory.logicnode.LogicNode.addLink(_Math, _SetVariable_001, 0, 2);
		armory.logicnode.LogicNode.addLink(_SetVariable_001, _SetVariable, 0, 0);
		var _Float_001 = new armory.logicnode.FloatNode(this);
		_Float_001.preallocInputs(1);
		_Float_001.preallocOutputs(1);
		armory.logicnode.LogicNode.addLink(new armory.logicnode.FloatNode(this, 0.5), _Float_001, 0, 0);
		armory.logicnode.LogicNode.addLink(_Float_001, _SetVariable, 0, 1);
		var _Math_010 = new armory.logicnode.MathNode(this);
		_Math_010.property0 = "Fract";
		_Math_010.property1 = false;
		_Math_010.preallocInputs(1);
		_Math_010.preallocOutputs(1);
		var _Math_003 = new armory.logicnode.MathNode(this);
		_Math_003.property0 = "Add";
		_Math_003.property1 = false;
		_Math_003.preallocInputs(3);
		_Math_003.preallocOutputs(1);
		armory.logicnode.LogicNode.addLink(_GetMouseMovement, _Math_003, 2, 0);
		armory.logicnode.LogicNode.addLink(_Float_001, _Math_003, 0, 1);
		armory.logicnode.LogicNode.addLink(new armory.logicnode.FloatNode(this, 1.0), _Math_003, 0, 2);
		armory.logicnode.LogicNode.addLink(_Math_003, _Math_010, 0, 0);
		armory.logicnode.LogicNode.addLink(_Math_010, _SetVariable, 0, 2);
		armory.logicnode.LogicNode.addLink(_SetVariable, new armory.logicnode.NullNode(this), 0, 0);
		var _TranslateOnLocalAxis = new armory.logicnode.TranslateOnLocalAxisNode(this);
		_TranslateOnLocalAxis.preallocInputs(5);
		_TranslateOnLocalAxis.preallocOutputs(1);
		var _Gate_001 = new armory.logicnode.GateNode(this);
		_Gate_001.property0 = "Between";
		_Gate_001.property1 = 9.999999747378752e-05;
		_Gate_001.preallocInputs(4);
		_Gate_001.preallocOutputs(2);
		var _SetObjectRotation = new armory.logicnode.SetRotationNode(this);
		_SetObjectRotation.property0 = "Euler Angles";
		_SetObjectRotation.preallocInputs(3);
		_SetObjectRotation.preallocOutputs(1);
		var _OnUpdate = new armory.logicnode.OnUpdateNode(this);
		_OnUpdate.property0 = "Update";
		_OnUpdate.preallocInputs(0);
		_OnUpdate.preallocOutputs(1);
		armory.logicnode.LogicNode.addLink(_OnUpdate, _SetObjectRotation, 0, 0);
		armory.logicnode.LogicNode.addLink(new armory.logicnode.ObjectNode(this, ""), _SetObjectRotation, 0, 1);
		var _RotationMath = new armory.logicnode.RotationMathNode(this);
		_RotationMath.property0 = "Compose";
		_RotationMath.preallocInputs(2);
		_RotationMath.preallocOutputs(1);
		var _RotationMath_004 = new armory.logicnode.RotationMathNode(this);
		_RotationMath_004.property0 = "Amplify";
		_RotationMath_004.preallocInputs(2);
		_RotationMath_004.preallocOutputs(1);
		var _RotationMath_001 = new armory.logicnode.RotationMathNode(this);
		_RotationMath_001.property0 = "Lerp";
		_RotationMath_001.preallocInputs(3);
		_RotationMath_001.preallocOutputs(1);
		var _Rotation = new armory.logicnode.RotationNode(this);
		_Rotation.property0 = "AxisAngle";
		_Rotation.property1 = "Deg";
		_Rotation.property2 = "XYZ";
		_Rotation.preallocInputs(2);
		_Rotation.preallocOutputs(1);
		var _Vector = new armory.logicnode.VectorNode(this);
		_Vector.preallocInputs(3);
		_Vector.preallocOutputs(1);
		armory.logicnode.LogicNode.addLink(new armory.logicnode.FloatNode(this, 0.0), _Vector, 0, 0);
		armory.logicnode.LogicNode.addLink(new armory.logicnode.FloatNode(this, 0.0), _Vector, 0, 1);
		armory.logicnode.LogicNode.addLink(new armory.logicnode.FloatNode(this, 1.0), _Vector, 0, 2);
		armory.logicnode.LogicNode.addLink(_Vector, _Rotation, 0, 0);
		var _Math_005 = new armory.logicnode.MathNode(this);
		_Math_005.property0 = "Divide";
		_Math_005.property1 = false;
		_Math_005.preallocInputs(2);
		_Math_005.preallocOutputs(1);
		var _Float_004 = new armory.logicnode.FloatNode(this);
		_Float_004.preallocInputs(1);
		_Float_004.preallocOutputs(1);
		armory.logicnode.LogicNode.addLink(new armory.logicnode.FloatNode(this, -180.0), _Float_004, 0, 0);
		armory.logicnode.LogicNode.addLink(_Float_004, _Math_005, 0, 0);
		armory.logicnode.LogicNode.addLink(new armory.logicnode.FloatNode(this, 2.0), _Math_005, 0, 1);
		armory.logicnode.LogicNode.addLink(_Math_005, _Rotation, 0, 1);
		armory.logicnode.LogicNode.addLink(_Rotation, _RotationMath_001, 0, 0);
		var _Rotation_001 = new armory.logicnode.RotationNode(this);
		_Rotation_001.property0 = "AxisAngle";
		_Rotation_001.property1 = "Deg";
		_Rotation_001.property2 = "XYZ";
		_Rotation_001.preallocInputs(2);
		_Rotation_001.preallocOutputs(1);
		armory.logicnode.LogicNode.addLink(_Vector, _Rotation_001, 0, 0);
		var _Math_008 = new armory.logicnode.MathNode(this);
		_Math_008.property0 = "Divide";
		_Math_008.property1 = false;
		_Math_008.preallocInputs(2);
		_Math_008.preallocOutputs(1);
		var _Float_005 = new armory.logicnode.FloatNode(this);
		_Float_005.preallocInputs(1);
		_Float_005.preallocOutputs(1);
		armory.logicnode.LogicNode.addLink(new armory.logicnode.FloatNode(this, 180.0), _Float_005, 0, 0);
		armory.logicnode.LogicNode.addLink(_Float_005, _Math_008, 0, 0);
		armory.logicnode.LogicNode.addLink(new armory.logicnode.FloatNode(this, 2.0), _Math_008, 0, 1);
		armory.logicnode.LogicNode.addLink(_Math_008, _Rotation_001, 0, 1);
		armory.logicnode.LogicNode.addLink(_Rotation_001, _RotationMath_001, 0, 1);
		armory.logicnode.LogicNode.addLink(_Float_001, _RotationMath_001, 0, 2);
		armory.logicnode.LogicNode.addLink(_RotationMath_001, _RotationMath_004, 0, 0);
		armory.logicnode.LogicNode.addLink(new armory.logicnode.FloatNode(this, 2.0), _RotationMath_004, 0, 1);
		armory.logicnode.LogicNode.addLink(_RotationMath_004, _RotationMath, 0, 0);
		var _RotationMath_003 = new armory.logicnode.RotationMathNode(this);
		_RotationMath_003.property0 = "Amplify";
		_RotationMath_003.preallocInputs(2);
		_RotationMath_003.preallocOutputs(1);
		var _RotationMath_002 = new armory.logicnode.RotationMathNode(this);
		_RotationMath_002.property0 = "Lerp";
		_RotationMath_002.preallocInputs(3);
		_RotationMath_002.preallocOutputs(1);
		var _Rotation_002 = new armory.logicnode.RotationNode(this);
		_Rotation_002.property0 = "AxisAngle";
		_Rotation_002.property1 = "Deg";
		_Rotation_002.property2 = "XYZ";
		_Rotation_002.preallocInputs(2);
		_Rotation_002.preallocOutputs(1);
		var _Vector_001 = new armory.logicnode.VectorNode(this);
		_Vector_001.preallocInputs(3);
		_Vector_001.preallocOutputs(1);
		armory.logicnode.LogicNode.addLink(new armory.logicnode.FloatNode(this, 1.0), _Vector_001, 0, 0);
		armory.logicnode.LogicNode.addLink(new armory.logicnode.FloatNode(this, 0.0), _Vector_001, 0, 1);
		armory.logicnode.LogicNode.addLink(new armory.logicnode.FloatNode(this, 0.0), _Vector_001, 0, 2);
		armory.logicnode.LogicNode.addLink(_Vector_001, _Rotation_002, 0, 0);
		var _Math_001 = new armory.logicnode.MathNode(this);
		_Math_001.property0 = "Divide";
		_Math_001.property1 = false;
		_Math_001.preallocInputs(2);
		_Math_001.preallocOutputs(1);
		var _Float_007 = new armory.logicnode.FloatNode(this);
		_Float_007.preallocInputs(1);
		_Float_007.preallocOutputs(1);
		armory.logicnode.LogicNode.addLink(new armory.logicnode.FloatNode(this, -90.0), _Float_007, 0, 0);
		armory.logicnode.LogicNode.addLink(_Float_007, _Math_001, 0, 0);
		armory.logicnode.LogicNode.addLink(new armory.logicnode.FloatNode(this, 2.0), _Math_001, 0, 1);
		armory.logicnode.LogicNode.addLink(_Math_001, _Rotation_002, 0, 1);
		armory.logicnode.LogicNode.addLink(_Rotation_002, _RotationMath_002, 0, 0);
		var _Rotation_003 = new armory.logicnode.RotationNode(this);
		_Rotation_003.property0 = "AxisAngle";
		_Rotation_003.property1 = "Deg";
		_Rotation_003.property2 = "XYZ";
		_Rotation_003.preallocInputs(2);
		_Rotation_003.preallocOutputs(1);
		armory.logicnode.LogicNode.addLink(_Vector_001, _Rotation_003, 0, 0);
		var _Math_004 = new armory.logicnode.MathNode(this);
		_Math_004.property0 = "Divide";
		_Math_004.property1 = false;
		_Math_004.preallocInputs(2);
		_Math_004.preallocOutputs(1);
		var _Float_006 = new armory.logicnode.FloatNode(this);
		_Float_006.preallocInputs(1);
		_Float_006.preallocOutputs(1);
		armory.logicnode.LogicNode.addLink(new armory.logicnode.FloatNode(this, 90.0), _Float_006, 0, 0);
		armory.logicnode.LogicNode.addLink(_Float_006, _Math_004, 0, 0);
		armory.logicnode.LogicNode.addLink(new armory.logicnode.FloatNode(this, 2.0), _Math_004, 0, 1);
		armory.logicnode.LogicNode.addLink(_Math_004, _Rotation_003, 0, 1);
		armory.logicnode.LogicNode.addLink(_Rotation_003, _RotationMath_002, 0, 1);
		armory.logicnode.LogicNode.addLink(_Float, _RotationMath_002, 0, 2);
		armory.logicnode.LogicNode.addLink(_RotationMath_002, _RotationMath_003, 0, 0);
		armory.logicnode.LogicNode.addLink(new armory.logicnode.FloatNode(this, -2.0), _RotationMath_003, 0, 1);
		armory.logicnode.LogicNode.addLink(_RotationMath_003, _RotationMath, 0, 1);
		armory.logicnode.LogicNode.addLink(_RotationMath, _SetObjectRotation, 0, 2);
		armory.logicnode.LogicNode.addLink(_SetObjectRotation, _Gate_001, 0, 0);
		var _Math_002 = new armory.logicnode.MathNode(this);
		_Math_002.property0 = "Add";
		_Math_002.property1 = false;
		_Math_002.preallocInputs(2);
		_Math_002.preallocOutputs(1);
		var _GetDistance = new armory.logicnode.GetDistanceNode(this);
		_GetDistance.preallocInputs(2);
		_GetDistance.preallocOutputs(1);
		armory.logicnode.LogicNode.addLink(new armory.logicnode.ObjectNode(this, ""), _GetDistance, 0, 0);
		var _GetObjectChild = new armory.logicnode.GetChildNode(this);
		_GetObjectChild.property0 = "Contains";
		_GetObjectChild.preallocInputs(2);
		_GetObjectChild.preallocOutputs(1);
		armory.logicnode.LogicNode.addLink(new armory.logicnode.ObjectNode(this, ""), _GetObjectChild, 0, 0);
		armory.logicnode.LogicNode.addLink(new armory.logicnode.StringNode(this, ""), _GetObjectChild, 0, 1);
		armory.logicnode.LogicNode.addLink(_GetObjectChild, _GetDistance, 0, 1);
		armory.logicnode.LogicNode.addLink(_GetDistance, _Math_002, 0, 0);
		var _GetMouseMovement_002 = new armory.logicnode.GetMouseMovementNode(this);
		_GetMouseMovement_002.preallocInputs(3);
		_GetMouseMovement_002.preallocOutputs(6);
		armory.logicnode.LogicNode.addLink(new armory.logicnode.FloatNode(this, -1.0), _GetMouseMovement_002, 0, 0);
		armory.logicnode.LogicNode.addLink(new armory.logicnode.FloatNode(this, -1.0), _GetMouseMovement_002, 0, 1);
		armory.logicnode.LogicNode.addLink(new armory.logicnode.FloatNode(this, 1.0), _GetMouseMovement_002, 0, 2);
		armory.logicnode.LogicNode.addLink(_GetMouseMovement_002, new armory.logicnode.FloatNode(this, 0.0), 0, 0);
		armory.logicnode.LogicNode.addLink(_GetMouseMovement_002, new armory.logicnode.FloatNode(this, 0.0), 1, 0);
		armory.logicnode.LogicNode.addLink(_GetMouseMovement_002, new armory.logicnode.FloatNode(this, 0.0), 2, 0);
		armory.logicnode.LogicNode.addLink(_GetMouseMovement_002, new armory.logicnode.FloatNode(this, 0.0), 3, 0);
		armory.logicnode.LogicNode.addLink(_GetMouseMovement_002, new armory.logicnode.IntegerNode(this, 0), 4, 0);
		armory.logicnode.LogicNode.addLink(_GetMouseMovement_002, _Math_002, 5, 1);
		armory.logicnode.LogicNode.addLink(_Math_002, _Gate_001, 0, 1);
		var _Float_008 = new armory.logicnode.FloatNode(this);
		_Float_008.preallocInputs(1);
		_Float_008.preallocOutputs(1);
		armory.logicnode.LogicNode.addLink(new armory.logicnode.FloatNode(this, 0.35000038146972656), _Float_008, 0, 0);
		armory.logicnode.LogicNode.addLink(_Float_008, _Gate_001, 0, 2);
		var _Float_009 = new armory.logicnode.FloatNode(this);
		_Float_009.preallocInputs(1);
		_Float_009.preallocOutputs(1);
		armory.logicnode.LogicNode.addLink(new armory.logicnode.FloatNode(this, 20.0), _Float_009, 0, 0);
		armory.logicnode.LogicNode.addLink(_Float_009, _Gate_001, 0, 3);
		armory.logicnode.LogicNode.addLink(_Gate_001, new armory.logicnode.NullNode(this), 1, 0);
		armory.logicnode.LogicNode.addLink(_Gate_001, _TranslateOnLocalAxis, 0, 0);
		armory.logicnode.LogicNode.addLink(_GetObjectChild, _TranslateOnLocalAxis, 0, 1);
		armory.logicnode.LogicNode.addLink(_GetMouseMovement_002, _TranslateOnLocalAxis, 5, 2);
		armory.logicnode.LogicNode.addLink(new armory.logicnode.IntegerNode(this, 2), _TranslateOnLocalAxis, 0, 3);
		armory.logicnode.LogicNode.addLink(new armory.logicnode.BooleanNode(this, false), _TranslateOnLocalAxis, 0, 4);
		armory.logicnode.LogicNode.addLink(_TranslateOnLocalAxis, new armory.logicnode.NullNode(this), 0, 0);
	}
}