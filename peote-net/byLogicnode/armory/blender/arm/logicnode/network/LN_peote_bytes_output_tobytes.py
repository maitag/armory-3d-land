from arm.logicnode.arm_nodes import *
import re

class PeoteBytesOutputToBytes(ArmLogicTreeNode):
    """Peote-Net node to get Bytes from BytesOutput"""
    bl_idname = 'LNPeoteBytesOutputToBytesNode'
    bl_label = 'Peote BytesOutput to Bytes'
    arm_version = 0

    def __init__(self):
        super(PeoteBytesOutputToBytes, self).__init__()
        self.register_id()

    def arm_init(self, context):
        # INPUTS:
        self.add_input('ArmDynamicSocket', 'BytesOutput')
        
        # OUTPUTS:
        self.add_output('ArmDynamicSocket', 'Bytes')

    def draw_label(self) -> str:
        return 'BytesOutput to Bytes'
