from arm.logicnode.arm_nodes import *
import re

class PeoteBytesOutputWrite(ArmLogicTreeNode):
    """Peote-Net node to write data into a chunk"""
    bl_idname = 'LNPeoteBytesOutputWriteNode'
    bl_label = 'Peote BytesOutput Write'
    arm_version = 0

    def set_type(self, value):
        # string
        if value == 0 and self.property0 != 'String':
            self.inputs.remove(self.inputs.values()[-1])
            self.add_input('ArmStringSocket', 'String')
        # int32 int16
        elif (value == 1 or value == 2) and self.property0 != 'Int32' and self.property0 != 'Int16':
            self.inputs.remove(self.inputs.values()[-1])
            self.add_input('ArmIntSocket', 'Integer')
        # float64 float32
        elif (value == 3 or value == 4) and self.property0 != 'Float' and self.property0 != 'Double':
            self.inputs.remove(self.inputs.values()[-1])
            self.add_input('ArmFloatSocket', 'Float')
        
        self['property0'] = value

    def get_type(self):
        return self.get('property0', 0)

    property0: HaxeEnumProperty(
        'property0',
        items = [('String', 'String', 'Write string'),
                 ('Int16',  'Int16',  'Write 2 byte integer'),
                 ('Int32',  'Int32',  'Write 4 byte integer'),
                 ('Float',  'Float',  'Write 4 byte float'),
                 ('Double', 'Double', 'Write 8 byte float'),
                 ],
        name='', set=set_type, get=get_type)

    def __init__(self):
        super(PeoteBytesOutputWrite, self).__init__()
        self.register_id()

    def arm_init(self, context):
        # INPUTS:
        self.add_input('ArmDynamicSocket', 'BytesOutput')
        self.add_input('ArmStringSocket', 'String', '')
        
        # OUTPUTS:
        self.add_output('ArmDynamicSocket', 'BytesOutput')
        self.add_output('ArmDynamicSocket', 'Bytes')

    def draw_buttons(self, context, layout):
        # enum of datatype
        layout.prop(self, 'property0')

    def draw_label(self) -> str:
        return f'Write {self.property0}'
