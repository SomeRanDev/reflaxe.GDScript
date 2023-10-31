package;

import Assert.assert;
import Assert.assertFloat;

class A {
	public function new() {}
}

class B {
	public function new() {}
}

class C extends B {
}

class TestStd {
	public static function test() {
		final a = new A();
		final b = new B();
		assert(Std.isOfType(a, A));
		assert(Std.isOfType(b, B));
		assert(!Std.isOfType(a, B));
		assert(!Std.isOfType(b, A));

		final c = Std.downcast(b, C);
		assert(c == null);

		assert(Std.string(123) == "123");
		assert(Std.string(false) == "false");
		assert(StringTools.startsWith(Std.string(a), "<RefCounted#"));

		assert(Std.int(2.3) == 2);
		assert(Std.int(999.99) == 999);

		assert(Std.parseInt("123") == 123);
		assertFloat(Std.parseFloat("1.5"), 1.5);

		final r = Std.random(10);
		assert(r >= 0 && r < 10);
	}
}
