from arm.logicnode.arm_nodes import *
import re

class PeoteServerSend(ArmLogicTreeNode):
    """Peote-Net node to send data to client"""
    bl_idname = 'LNPeoteServerSendNode'
    bl_label = 'Peote Server Send'
    arm_version = 0

    def __init__(self):
        super(PeoteServerSend, self).__init__()
        self.register_id()

    def arm_init(self, context):
        # INPUTS:
        self.add_input('ArmNodeSocketAction', 'In')
        self.add_input('ArmDynamicSocket', 'Peote Server')
        self.add_input('ArmIntSocket', 'User Number')
        self.add_input('ArmDynamicSocket', 'Bytes')
        
        # OUTPUTS:
        self.add_output('ArmNodeSocketAction', 'Out')
