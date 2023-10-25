from arm.logicnode.arm_nodes import *
import re

class PeoteBytesOutputWrite(ArmLogicTreeNode):
    """Peote-Net node to write data into BytesOutput"""
    bl_idname = 'LNPeoteBytesOutputWriteNode'
    bl_label = 'Peote BytesOutput Write'
    arm_version = 0

    def set_type(self, value):
        if value == 0 and self.property0 != 'String':
            self.inputs.remove(self.inputs.values()[-1])
            self.add_input('ArmStringSocket', 'String')
        elif (value > 0 and value < 8) and (not ('Int' in self.property0)):
            self.inputs.remove(self.inputs.values()[-1])
            self.add_input('ArmIntSocket', 'Integer')
        elif (value == 8) and self.property0 != 'Bool':
            self.inputs.remove(self.inputs.values()[-1])
            self.add_input('ArmBoolSocket', 'Bool')
        elif (value == 9) and self.property0 != 'Float':
            self.inputs.remove(self.inputs.values()[-1])
            self.add_input('ArmFloatSocket', 'Float')
        elif (value == 10) and self.property0 != 'Vector':
            self.inputs.remove(self.inputs.values()[-1])
            self.add_input('ArmVectorSocket', 'Vector')
        elif (value == 11) and self.property0 != 'Rotation':
            self.inputs.remove(self.inputs.values()[-1])
            self.add_input('ArmRotationSocket', 'Rotation')
        elif (value == 12) and self.property0 != 'Color':
            self.inputs.remove(self.inputs.values()[-1])
            self.add_input('ArmColorSocket', 'Color')
        elif (value == 13) and self.property0 != 'Bytes':
            self.inputs.remove(self.inputs.values()[-1])
            self.add_input('ArmDynamicSocket', 'Bytes')
        
        self['property0'] = value

    def get_type(self):
        return self.get('property0', 0)

    property0: HaxeEnumProperty(
        'property0',
        items = [('String',  'String',   'Write string'),
                 ('Int8',    'Int8',     'Write 1 byte signed integer'),
                 ('Int16',   'Int16',    'Write 2 byte signed integer'),
                 ('Int24',   'Int24',    'Write 3 byte signed integer'),
                 ('Int32',   'Int32',    'Write 4 byte signed integer'),
                 ('UInt8',   'UInt8',    'Write 1 byte unsigned integer'),
                 ('UInt16',  'UInt16',   'Write 2 byte unsigned integer'),
                 ('UInt24',  'UInt24',   'Write 3 byte unsigned integer'),
                 ('Bool',    'Bool',     'Write Boolean'),
                 ('Float',   'Float',    'Write 4 byte float'),
                 ('Vector',  'Vector',   'Write Vector of 3 floats'),
                 ('Rotation','Rotation', 'Write Quaternation (Vector of 4 floats)'),
                 ('Color',   'Color',    'Write Color (Vector of 4 floats)'),
                 ('Bytes',   'Bytes',    'Write Bytes'),
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

    def draw_buttons(self, context, layout):
        # enum of datatype
        layout.prop(self, 'property0')

    def draw_label(self) -> str:
        return f'Write {self.property0}'
