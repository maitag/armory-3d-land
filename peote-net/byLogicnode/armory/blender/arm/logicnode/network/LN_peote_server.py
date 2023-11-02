from arm.logicnode.arm_nodes import *
import re

class PeoteServerNode(ArmLogicTreeNode):
    """Peote-Net node to create a network server"""
    bl_idname = 'LNPeoteServerNode'
    bl_label = 'Peote Server'
    arm_version = 0

    def set_mode(self, value):
        if value == 0 and self.property0 != 'onData':
            if self.property0 == 'RPC':
                self.inputs.remove(self.inputs.values()[-1])
                self.outputs.remove(self.outputs.values()[-1])
                self.outputs.remove(self.outputs.values()[-1])
                self.add_output('ArmDynamicSocket', 'Bytes')
            self.outputs.values()[-2].name = 'On Data'
        elif value == 1 and self.property0 != 'onDataChunk':
            if self.property0 == 'RPC':
                self.inputs.remove(self.inputs.values()[-1])
                self.outputs.remove(self.outputs.values()[-1])
                self.outputs.remove(self.outputs.values()[-1])
                self.add_output('ArmDynamicSocket', 'Bytes')
            self.outputs.values()[-2].name = 'On Datachunk'
        elif value == 2 and self.property0 != 'RPC':
            self.add_input('ArmNodeSocketArray', 'Server Remote Classnames')
            self.outputs.remove(self.outputs.values()[-1])
            self.add_output('ArmIntSocket', 'Remote ID')
            self.add_output('ArmDynamicSocket', 'User Remote Instances')
            self.outputs.values()[-3].name = 'On Remote ready'
        self['property0'] = value

    def get_mode(self):
        return self.get('property0', 0)

    property0: HaxeEnumProperty(
        'property0',
        items = [('onData', 'On Data', 'The "On Data" handler is always called when new bytes arrive'),
                 ('onDataChunk', 'On DataChunk',  'The "On DataChunk" handler is called when a complete chunk of bytes is ready'),
                 ('RPC', 'RPC', 'Using haxe-classes for Remote Procedure Call'),
                 ],
        name='', set=set_mode, get=get_mode)

    property1: HaxeEnumProperty(
        'property1',
        items = [('1', '256 Bytes', 'Max Chunksize: 256 Bytes'),
                 ('2', '32 KB', 'Max Chunksize: 32 KiloBytes'),
                 ('3', '4 MB', 'Max Chunksize: 4 MegaBytes'),
                 ('4', '512 MB', 'Max Chunksize: 512 MegaBytes'),
                 ('5', '2 GB', 'Max Chunksize: 2 GigaBytes'),
                 ],
        name='')


    def __init__(self):
        super(PeoteServerNode, self).__init__()
        self.register_id()

    def arm_init(self, context):
        
        # INPUTS:
        self.add_input('ArmNodeSocketAction', 'Connect')
        self.add_input('ArmBoolSocket', 'Emulate Network', True)
        self.add_input('ArmStringSocket', 'Host', 'localhost')
        self.add_input('ArmIntSocket', 'Port', 7680)
        self.add_input('ArmStringSocket', 'Channel', 'armtest')
        
         # OUTPUTS:
        self.add_output('ArmDynamicSocket', 'Peote Server')
        self.add_output('ArmNodeSocketAction', 'On Create')
        self.add_output('ArmNodeSocketAction', 'On User Connect')
        self.add_output('ArmNodeSocketAction', 'On User Disconnect')
        self.add_output('ArmNodeSocketAction', 'On User Error')
        self.add_output('ArmIntSocket', 'User Number')
        self.add_output('ArmNodeSocketAction', 'On Data')
        self.add_output('ArmDynamicSocket', 'Bytes')

    def draw_buttons(self, context, layout):

        # RPC Class Property
        layout.prop(self, 'property0')
        
        # max Chunksize Property (only for datachunk-mode)
        if self.property0 == 'onDataChunk': layout.prop(self, 'property1')

    def draw_label(self) -> str:
        if self.property0 != 'RPC': return f'{self.bl_label}'
        else: return f'{self.bl_label} RPC'
