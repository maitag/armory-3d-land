from arm.logicnode.arm_nodes import *
import re

class PeoteBytesInputRead(ArmLogicTreeNode):
    """Peote-Net node to read data from BytesInput"""
    bl_idname = 'LNPeoteBytesInputReadNode'
    bl_label = 'Peote BytesInput Read'
    arm_version = 0

    def set_type(self, value):
        if value == 0 and self.property0 != 'String':
            self.outputs.remove(self.outputs.values()[-1])
            self.add_output('ArmStringSocket', 'String')
        elif (value > 0 and value < 8) and (not ('Int' in self.property0)):
            self.outputs.remove(self.outputs.values()[-1])
            self.add_output('ArmIntSocket', 'Integer')
        elif (value == 8) and self.property0 != 'Bool':
            self.outputs.remove(self.outputs.values()[-1])
            self.add_output('ArmBoolSocket', 'Bool')
        elif (value == 9) and self.property0 != 'Float':
            self.outputs.remove(self.outputs.values()[-1])
            self.add_output('ArmFloatSocket', 'Float')
        elif (value == 10) and self.property0 != 'Vector':
            self.outputs.remove(self.outputs.values()[-1])
            self.add_output('ArmVectorSocket', 'Vector')
        elif (value == 11) and self.property0 != 'Rotation':
            self.outputs.remove(self.outputs.values()[-1])
            self.add_output('ArmRotationSocket', 'Rotation')
        elif (value == 12) and self.property0 != 'Color':
            self.outputs.remove(self.outputs.values()[-1])
            self.add_output('ArmColorSocket', 'Color')
        elif (value == 13) and self.property0 != 'Bytes':
            self.outputs.remove(self.outputs.values()[-1])
            self.add_output('ArmDynamicSocket', 'Bytes')
        
        self['property0'] = value

    def get_type(self):
        return self.get('property0', 0)

    property0: HaxeEnumProperty(
        'property0',
        items = [('String',  'String',   'Read string'),
                 ('Int8',    'Int8',     'Read 1 byte signed integer'),
                 ('Int16',   'Int16',    'Read 2 byte signed integer'),
                 ('Int24',   'Int24',    'Read 3 byte signed integer'),
                 ('Int32',   'Int32',    'Read 4 byte signed integer'),
                 ('UInt8',   'UInt8',    'Read 1 byte unsigned integer'),
                 ('UInt16',  'UInt16',   'Read 2 byte unsigned integer'),
                 ('UInt24',  'UInt24',   'Read 3 byte unsigned integer'),
                 ('Bool',    'Bool',     'Read Boolean'),
                 ('Float',   'Float',    'Read 4 byte float'),
                 ('Vector',  'Vector',   'Read Vector of 3 floats'),
                 ('Rotation','Rotation', 'Read Quaternation (Vector of 4 floats)'),
                 ('Color',   'Color',    'Read Color (Vector of 4 floats)'),
                 ('Bytes',   'Bytes',    'Read Bytes'),
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
