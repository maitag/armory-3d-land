package armory.logicnode;

import haxe.ds.IntMap;
import iron.math.Vec4;

class PeoteServerRemoteLoop extends LogicNode {
	public var key:Int;
	public var value:Array<Dynamic>;

	public function new(tree: LogicTree) {
		super(tree);
	}

	override function run(from: Int) {

		var map:IntMap<Array<Dynamic>> = inputs[1].get();
		if (map == null) return;
		
		for (k in map.keys()) {
			key = k;
			value = map.get(k);
			runOutput(0);

			if (tree.loopBreak) {
				tree.loopBreak = false;
				break;
			}
			
			if (tree.loopContinue) {
				tree.loopContinue = false;
				continue;
			}
		}
		runOutput(3);
	}

	override function get(from: Int): Dynamic {
		if (from == 1) return key;
		else return value;
	}
}
