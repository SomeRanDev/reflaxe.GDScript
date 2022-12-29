package;

import Assert.assert;

@:tool
class TestMeta {
	@:onready
	var prop = 123;

	@:exportEnum("Hello", "World")
	var enumField = 0;

	public function new() {
	}

	public static function test() {
		// not really sure how to write tests for annotations
		// they work, just take my word on it Xd
		final tm = new TestMeta();
		assert(tm.prop == 123);
	}
}
