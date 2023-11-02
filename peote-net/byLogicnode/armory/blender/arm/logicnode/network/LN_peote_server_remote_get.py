from arm.logicnode.arm_nodes import *


class PeoteServerRemoteGet(ArmLogicTreeNode):
    """Get Servers Remote Instances for a connected User"""
    bl_idname = 'LNPeoteServerRemoteGet'
    bl_label = 'Peote Server Get Remote Instances'
    arm_version = 1

    def init(self, context):
        self.add_input('ArmDynamicSocket', 'User Remote Instances')
        self.add_input('ArmIntSocket', 'User ID')

        self.add_output('ArmDynamicSocket', 'Remote Instances')

    def draw_label(self) -> str:
        return 'Get Remote Instances'
