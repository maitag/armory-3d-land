from arm.logicnode.arm_nodes import *
import re

class PeoteClientNode(ArmLogicTreeNode):
    """Peote-Net node to create a network client"""
    bl_idname = 'LNPeoteClientNode'
    bl_label = 'Peote Client'
    arm_version = 0

    num_params: IntProperty(default=1, min=0)

    def set_rpc_class(self, value):
        self['property0'] = value
        # TODO: Check for errors
        self['rpc_class_error'] = False

    def get_rpc_class(self):
        return self.get('property0', '')

    property0: HaxeStringProperty('property0', name='RPC Class', description='Name of haxe-class what defines remote client functions', set=set_rpc_class, get=get_rpc_class)

    def __init__(self):
        super(PeoteClientNode, self).__init__()
        self.register_id()


    def arm_init(self, context):
        
        # INPUTS:
        self.add_input('ArmNodeSocketAction', 'Connect')
        self.add_input('ArmStringSocket', 'Host', 'localhost')
        self.add_input('ArmIntSocket', 'Port', 7680)
        self.add_input('ArmStringSocket', 'Channel', 'armtest')
        
         # OUTPUTS:
        self.add_output('ArmDynamicSocket', 'Peote Client')
        self.add_output('ArmNodeSocketAction', 'On Enter')
        self.add_output('ArmNodeSocketAction', 'On Disconnect')
        self.add_output('ArmNodeSocketAction', 'On Error')
        self.add_output('ArmNodeSocketAction', 'On Remote ready')
        self.add_output('ArmIntSocket', 'Server Remote ID')

    def add_rpc_class(self):
        if self.num_params < 26:
            self.num_params += 1
            # self['property1'] = self.num_params

    # def add_sockets(self):
        # if self.num_params < 26:
            # self.add_input('ArmFloatSocket', self.get_variable_name(self.num_params), default_value=0.0)
            # self.num_params += 1
            # self['property1'] = self.num_params

    # def remove_sockets(self):
        # if self.num_params > 0:
            # self.inputs.remove(self.inputs.values()[-1])
            # self.num_params -= 1
            # self['property1'] = self.num_params

    def draw_buttons(self, context, layout):
        # Button ADD parameter
        row = layout.row(align=True)
        column = row.column(align=True)
        op = column.operator('arm.node_call_func', text='Add Param', icon='PLUS', emboss=True)
        op.node_index = self.get_id_str()
        op.callback_name = 'add_rpc_class'
        if self.num_params == 4:
            column.enabled = False

        # RPC Class Property
        layout.prop(self, 'property0')

        # Emulate Network Property
        # layout.prop(self, 'property0')

        # Expression Property
        # row = layout.row(align=True)
        # column = row.column(align=True)
        # TODO:
        #column.alert = self['exp_error']
        # column.prop(self, 'property2', icon='FORCE_HARMONIC')

        # Button ADD parameter
        # row = layout.row(align=True)
        # column = row.column(align=True)
        # op = column.operator('arm.node_call_func', text='Add Param', icon='PLUS', emboss=True)
        # op.node_index = self.get_id_str()
        # op.callback_name = 'add_sockets'
        # if self.num_params == 26:
            # column.enabled = False

        # Button REMOVE parameter
        # column = row.column(align=True)
        # op = column.operator('arm.node_call_func', text='', icon='X', emboss=True)
        # op.node_index = self.get_id_str()
        # op.callback_name = 'remove_sockets'
        # if self.num_params == 0:
            # column.enabled = False
