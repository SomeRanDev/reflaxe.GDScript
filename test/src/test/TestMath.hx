package test;

import Assert.assert;
import Assert.assertFloat;

class TestMath {
	public static function test() {
		assert(Math.ceil(2 * Math.pow(Math.PI, 2)) == 20);

		assert(Math.abs(-3) == 3);

		assert(Math.ceil(2.1) == 3);
		assert(Math.ceil(0.9) == 1);

		assert(Math.ceil(Math.exp(1.0)) == 3);
		assert(Math.floor(Math.exp(1.0)) == 2);

		assert(Math.floor(99.9) == 99);

		assert(Math.isFinite(12));
		assert(Math.isNaN(Math.NaN));
		assert(!Math.isFinite(Math.POSITIVE_INFINITY));
		assert(!Math.isFinite(Math.NEGATIVE_INFINITY));

		assertFloat(Math.sin(Math.PI), 0.0);
		assertFloat(Math.cos(0), 1);
		assertFloat(Math.tan(4), 1.157821);
		assertFloat(Math.asin(1), 1.570796);

		// https://github.com/godotengine/godot/commit/50c5ed4876250f785be54b8f6124e7663afa38dc
		// acos now safe to call
		assertFloat(Math.acos(100), 0);

		assertFloat(Math.atan(12), 1.4876);
		assertFloat(Math.atan2(-3, 3), -0.78539);

		assertFloat(Math.log(10), 2.30258);

		assert(Math.sqrt(25) == 5);
		assert(Math.sqrt(100) == 10);
	}
}
