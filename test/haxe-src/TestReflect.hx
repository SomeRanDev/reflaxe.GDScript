package;

import Assert.assert;

class MyClass {
	public function new() {}

	public var myProp(get, set): Int;

	var internalProp: Int = 1;

	function get_myProp() return internalProp;
	function set_myProp(v) return internalProp = v;
}

class TestReflect {
	public static function test() {
		final obj = {
			num: 123,
			str: "String"
		};

		final cls = new MyClass();

		assert(Reflect.hasField(obj, "num"));
		assert(!Reflect.hasField(obj, "dog"));

		assert(Reflect.field(obj, "str") == "String");

		Reflect.setField(obj, "num", 444);
		assert(Reflect.field(obj, "num") == 444);

		assert(Reflect.getProperty(cls, "myProp") == 1);

		Reflect.setProperty(cls, "myProp", 10);
		assert(Reflect.getProperty(cls, "myProp") == 10);

		final func = function(a) { return a + 123; }
		assert(Reflect.callMethod(null, func, [100]) == 223);

		assert(Reflect.fields(cls).length == 4);

		assert(!Reflect.isFunction(obj));
		assert(Reflect.isFunction(func));

		assert(Reflect.compare(12, 14) == -1);
		assert(Reflect.compareMethods(func, func));

		assert(!Reflect.isObject(obj));

		// Checks if a Dictionary, so this must be true
		assert(Reflect.isEnumValue(obj));

		final obj2 = Reflect.copy(obj);
		assert(obj2.str == obj.str);

		Reflect.deleteField(obj, "num");
		assert((obj.num: Null<Int>) == null);
	}
}
