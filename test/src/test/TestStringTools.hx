package test;

import Assert.assert;

class TestStringTools {
	public static function test() {
		assert(StringTools.hex(123) == "7B");
	}
}