from arm.logicnode.arm_nodes import *
import re

class PeoteServerClose(ArmLogicTreeNode):
    """Peote-Net node to close a server connection"""
    bl_idname = 'LNPeoteServerCloseNode'
    bl_label = 'Peote Server Close'
    arm_version = 0

    def __init__(self):
        super(PeoteServerClose, self).__init__()
        self.register_id()

    def arm_init(self, context):
        # INPUTS:
        self.add_input('ArmNodeSocketAction', 'In')
        self.add_input('ArmDynamicSocket', 'Peote Server')
        
        # OUTPUTS:
        self.add_output('ArmNodeSocketAction', 'Out')
