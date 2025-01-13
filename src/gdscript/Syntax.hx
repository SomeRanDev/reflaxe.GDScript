package gdscript;

extern class Syntax {
	@:nativeFunctionCode("({arg0} is {arg1})")
	public static function is<T, U>(any: T, class_type: Class<U>): Bool;
}
