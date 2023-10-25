from arm.logicnode.arm_nodes import *
import re

class PeoteBytesInput(ArmLogicTreeNode):
    """Peote-Net node to create new BytesInput"""
    bl_idname = 'LNPeoteBytesInputNode'
    bl_label = 'Peote BytesInput'
    arm_version = 0

    property0: HaxeEnumProperty(
        'property0',
        items = [('1', '256 Bytes', 'Max String Size: 256 Bytes'),
                 ('2', '32 KB', 'Max String Size: 32 KiloBytes'),
                 ('3', '4 MB', 'Max String Size: 4 MegaBytes'),
                 ('4', '512 MB', 'Max String Size: 512 MegaBytes'),
                 ('5', '2 GB', 'Max String Size: 2 GigaBytes'),
                 ],
        name='')

    property1: HaxeEnumProperty(
        'property1',
        items = [('Default', 'Default Endian', 'Default Endian Byteorder for Integers'),
                 ('BigEndian', 'Big Endian', 'Big Endian Byteorder for Integers'),
                 ('LittleEndian', 'Little Endian', 'Little Endian Byteorder for Integers'),
                 ],
        name='')

    def __init__(self):
        super(PeoteBytesInput, self).__init__()
        self.register_id()

    def arm_init(self, context):
        # INPUTS:
        self.add_input('ArmNodeSocketAction', 'In')
        self.add_input('ArmDynamicSocket', 'Bytes')

        # OUTPUTS:
        self.add_output('ArmNodeSocketAction', 'Out')
        self.add_output('ArmDynamicSocket', 'BytesInput')
        self.add_output('ArmIntSocket', 'length')

    def draw_buttons(self, context, layout):
        # enum of max chunksize
        layout.prop(self, 'property0')
        layout.prop(self, 'property1')

    def draw_label(self) -> str:
        return 'New BytesInput'
