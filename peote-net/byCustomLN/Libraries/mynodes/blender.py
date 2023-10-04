from bpy.types import Node
from arm.logicnode.arm_nodes import *
import arm.nodes_logic


class PeoteServerNode(ArmLogicTreeNode):
    """PeoteServerNode"""
    bl_idname = 'LNPeoteServerNode'
    bl_label = 'PeoteServer'

    # tooltip in the add node menu.
    # If `bl_description` does not exist, the docstring of this node is used instead.
    bl_description = 'peote-net Server'

    arm_category = 'Peote-Net'

    arm_version = 0

    def init(self, context):
        self.add_input('ArmNodeSocketAction', 'Connect')
        self.add_input('ArmStringSocket', 'Host', 'localhost')
        self.add_input('ArmIntSocket', 'Port', 7680)
        self.add_input('ArmStringSocket', 'Channel', 'armtest')
        self.add_input('ArmBoolSocket', 'Emulate Network')
        self.add_input('ArmNodeSocketAction', 'Close')
        self.add_output('ArmNodeSocketAction', 'On Create')
        self.add_output('ArmNodeSocketAction', 'On User Connect')
        self.add_output('ArmNodeSocketAction', 'On User Disconnect')
        self.add_output('ArmNodeSocketAction', 'On User Error')
        self.add_output('ArmIntSocket', 'User Number')


class PeoteClientNode(ArmLogicTreeNode):
    """PeoteClientNode"""
    bl_idname = 'LNPeoteClientNode'
    bl_label = 'PeoteClient'
    bl_description = 'Peote-Net Client'

    arm_category = 'Peote-Net'

    arm_version = 0

    def init(self, context):
        self.add_input('ArmNodeSocketAction', 'Connect')
        self.add_input('ArmStringSocket', 'Host', 'localhost')
        self.add_input('ArmIntSocket', 'Port', 7680)
        self.add_input('ArmStringSocket', 'Channel', 'armtest')
        self.add_input('ArmNodeSocketAction', 'Close')
        self.add_output('ArmNodeSocketAction', 'On Enter')
        self.add_output('ArmNodeSocketAction', 'On Disconnect')
        self.add_output('ArmNodeSocketAction', 'On Error')


def register():
    """This function is called when Armory loads this library."""

    # peote-net category
    add_category('Peote-Net', icon='EVENT_C')

    # Register new Nodes
    PeoteServerNode.on_register()
    PeoteClientNode.on_register()

