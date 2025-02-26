package test;

import Assert.assert;

class TestSignals {
	@:signal
	function my_signal(i: Int) {}

	public static function test() {
		final t = new TestSignals();
		t.do_test();
	}

	public function new() {
	}

	function do_test() {
		untyped __gdscript__("connect(\"my_signal\", {0})", test2);
		untyped __gdscript__("emit_signal(\"my_signal\", {0})", 123);
	}

	function test2(i: Int) {
		assert(i == 123);
	}
}
