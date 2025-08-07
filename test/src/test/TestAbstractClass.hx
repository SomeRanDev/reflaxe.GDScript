package test;

import Assert.assert;

class MyObject {
	public var bla = 123;
	public function new() {}
}

abstract class MyAbstractClass {
	public function new() {}
	public abstract function getNothing(): Void;
	public abstract function getInt(): Int;
	public abstract function getBool(): Bool;
	public abstract function getObject(): MyObject;
}

class MyChildOfAbstractClass extends MyAbstractClass {
	public function getNothing(): Void {}
	public function getInt(): Int { return 123; }
	public function getBool(): Bool { return false; }
	public function getObject(): MyObject { return new MyObject(); }
}

class MyChildOfAbstractClass2 extends MyAbstractClass {
	public function getNothing(): Void {}
	public function getInt(): Int { return 321; }
	public function getBool(): Bool { return true; }
	public function getObject(): MyObject { return null; }
}

class TestAbstractClass {
	@:dce(Off)
	public static function test() {
		final one: MyAbstractClass = new MyChildOfAbstractClass();
		assert(one.getInt() == 123);
		assert(one.getBool() == false);
		assert(one.getObject() != null);

		final one: MyAbstractClass = new MyChildOfAbstractClass2();
		assert(one.getInt() == 321);
		assert(one.getBool() == true);
		assert(one.getObject() == null);

		trace("Test this worked??");
	}
}
