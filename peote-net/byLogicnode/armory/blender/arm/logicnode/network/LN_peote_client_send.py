from arm.logicnode.arm_nodes import *
import re

class PeoteClientSend(ArmLogicTreeNode):
    """Peote-Net node to send data to server"""
    bl_idname = 'LNPeoteClientSendNode'
    bl_label = 'Peote Client Send'
    arm_version = 0

    def __init__(self):
        super(PeoteClientSend, self).__init__()
        self.register_id()

    def arm_init(self, context):
        # INPUTS:
        self.add_input('ArmNodeSocketAction', 'In')
        self.add_input('ArmDynamicSocket', 'Peote Client')
        self.add_input('ArmDynamicSocket', 'Bytes')
        
        # OUTPUTS:
        self.add_output('ArmNodeSocketAction', 'Out')
