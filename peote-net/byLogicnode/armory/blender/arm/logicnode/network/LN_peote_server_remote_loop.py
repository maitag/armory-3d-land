from arm.logicnode.arm_nodes import *


class PeoteServerRemoteLoop(ArmLogicTreeNode):
    """Loop throught Servers Remote Instances for all connected Users"""
    bl_idname = 'LNPeoteServerRemoteLoop'
    bl_label = 'Peote Server Loop Remote Instances'
    arm_version = 1


    def init(self, context):
        self.add_input('ArmNodeSocketAction', 'In')
        self.add_input('ArmDynamicSocket', 'User Remote Instances')

        self.add_output('ArmNodeSocketAction', 'Loop')
        self.add_output('ArmIntSocket', 'User ID')
        self.add_output('ArmDynamicSocket', 'Remote Instances')
        self.add_output('ArmNodeSocketAction', 'Done')

    def draw_label(self) -> str:
        return 'Loop User Remote Instances'
