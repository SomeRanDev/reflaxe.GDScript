package test;

import Assert.assert;

class OtherClass {
	public static var str(default, null) = "";

	public static dynamic function add() {
		str += "|";
	}

	public static function clear() {
		str = "";
	}
}

class TestStaticVar {
	public static var count = 0;

	public function new() {
		count++;
	}

	public static function test() {
		count = 10;

		assert(count == 10);

		final list = [];
		for(i in 0...10) {
			list.push(new TestStaticVar());
		}

		assert(count == 20);

		assert(OtherClass.str.length == 0);

		for(i in 0...3) {
			OtherClass.add();
		}

		assert(OtherClass.str.length == 3);

		OtherClass.clear();

		assert(OtherClass.str.length == 0);

		final old = OtherClass.add;
		OtherClass.add = function() {
			old();
			old();
		}

		OtherClass.add();

		assert(OtherClass.str == "||");

		if(OtherClass.add != null) {
			assert(true);
		} else {
			assert(false);
		}
	}
}
