package;

extern class Std {
	@:deprecated('Std.is is deprecated. Use Std.isOfType instead.')
	public extern inline static function is(v: Dynamic, t: Dynamic): Bool return isOfType(v, t);
	public extern inline static function isOfType(v: Dynamic, t: Dynamic): Bool {
		return untyped __gdscript__("{}.get_class() == {}.get_class_name()", v, t);
	}

	@:deprecated('Std.instance() is deprecated. Use Std.downcast() instead.')
	public extern inline static function instance<T: {}, S: T>(value: T, c: Class<S>): S return downcast(value, c);
	public extern inline static function downcast<T: {}, S: T>(value: T, c: Class<S>): S return cast value;

	@:native("String")
	public static function string(s: Dynamic): String;

	@:native("int")
	public static function int(x: Float): Int;

	@:nativeFunctionCode("{arg0}.to_int()")
	public static function parseInt(x: String): Null<Int>;

	@:nativeFunctionCode("{arg0}.to_int()")
	public  static function parseFloat(x: String): Float;

	@:nativeFunctionCode("floor(randf() * {arg0})")
	public static function random(x: Int): Int;
}
