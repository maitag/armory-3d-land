from arm.logicnode.arm_nodes import *
import re

class PeoteClientClose(ArmLogicTreeNode):
    """Peote-Net node to close a client connection"""
    bl_idname = 'LNPeoteClientCloseNode'
    bl_label = 'Peote Client Close'
    arm_version = 0

    def __init__(self):
        super(PeoteClientClose, self).__init__()
        self.register_id()

    def arm_init(self, context):
        # INPUTS:
        self.add_input('ArmNodeSocketAction', 'In')
        self.add_input('ArmDynamicSocket', 'Peote Client')
        
        # OUTPUTS:
        self.add_output('ArmNodeSocketAction', 'Out')
