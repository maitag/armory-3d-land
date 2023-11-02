package armory.logicnode;

import haxe.ds.IntMap;

class PeoteServerRemoteGet extends LogicNode {
  
	public function new(tree:LogicTree) {
		super(tree);
	}

	override function get(from: Int):Dynamic {
		var map:IntMap<Array<Dynamic>> = inputs[0].get();
		if (map == null) return null;

		var key:Int = inputs[1].get();
		return map.get(key);   
	}
}
