package;

extern class Std {
	@:deprecated('Std.is is deprecated. Use Std.isOfType instead.')
	public extern inline static function is(v: Dynamic, t: Dynamic): Bool return isOfType(v, t);

	@:nativeFunctionCode("({arg0} is {arg1})")
	public static function isOfType(v: Dynamic, t: Dynamic): Bool;

	@:deprecated('Std.instance() is deprecated. Use Std.downcast() instead.')
	public extern inline static function instance<T: {}, S: T>(value: T, c: Class<S>): S return downcast(value, c);

	@:nativeFunctionCode("({arg0} as {arg1})")
	public static function downcast<T: {}, S: T>(value: T, c: Class<S>): S;

	@:native("str")
	public static function string(s: Dynamic): String;

	@:native("int")
	public static function int(x: Float): Int;

	@:nativeFunctionCode("{arg0}.to_int()")
	public static function parseInt(x: String): Null<Int>;

	@:nativeFunctionCode("{arg0}.to_float()")
	public  static function parseFloat(x: String): Float;

	@:nativeFunctionCode("floor(randf() * {arg0})")
	public static function random(x: Int): Int;
}
