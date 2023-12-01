package test;

class TestClass {
	var a: Int = 2;
	var b: Float = 3;
	var c: Bool = false;

	public function new() {
		if(!c) {
			trace(a, b);
		}
	}

	public static function test() {
		trace(new TestClass());
	}
}
