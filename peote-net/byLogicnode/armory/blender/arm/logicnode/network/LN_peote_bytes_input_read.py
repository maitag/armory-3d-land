from arm.logicnode.arm_nodes import *
import re

class PeoteBytesInputRead(ArmLogicTreeNode):
    """Peote-Net node to read data from a chunk"""
    bl_idname = 'LNPeoteBytesInputReadNode'
    bl_label = 'Peote BytesInput Read'
    arm_version = 0

    def set_type(self, value):
        # string
        if value == 0 and self.property0 != 'String':
            self.outputs.remove(self.outputs.values()[-1])
            self.add_output('ArmStringSocket', 'String')
        # int32 int16
        elif (value == 1 or value == 2) and self.property0 != 'Int16' and self.property0 != 'Int32':
            self.outputs.remove(self.outputs.values()[-1])
            self.add_output('ArmIntSocket', 'Integer')
        # float64 float32
        elif (value == 3 or value == 4) and self.property0 != 'Float' and self.property0 != 'Double':
            self.outputs.remove(self.outputs.values()[-1])
            self.add_output('ArmFloatSocket', 'Float')
        
        self['property0'] = value

    def get_type(self):
        return self.get('property0', 0)

    property0: HaxeEnumProperty(
        'property0',
        items = [('String', 'String', 'Read string'),
                 ('Int16',  'Int16',  'Read 2 byte integer'),
                 ('Int32',  'Int32',  'Read 4 byte integer'),
                 ('Float',  'Float',  'Read 4 byte float'),
                 ('Double', 'Double', 'Read 8 byte float'),
                 ],
        name='', set=set_type, get=get_type)

    def __init__(self):
        super(PeoteBytesInputRead, self).__init__()
        self.register_id()

    def arm_init(self, context):
        # INPUTS:
        self.add_input('ArmNodeSocketAction', 'In')
        self.add_input('ArmDynamicSocket', 'BytesInput')
        
        # OUTPUTS:
        self.add_output('ArmNodeSocketAction', 'Out')
        self.add_output('ArmStringSocket', 'String', '')

    def draw_buttons(self, context, layout):
        # enum of datatype
        layout.prop(self, 'property0')

    def draw_label(self) -> str:
        return f'Read {self.property0}'
