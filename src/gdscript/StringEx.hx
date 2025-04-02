package gdscript;

/**
	Allows Haxe's `String`s to use functions from Godot's `String` type.

	Last updated for Godot 4.4.
**/
class StringEx {
	public static extern inline function replace(self: String, what: String, forwhat: String): String return untyped __gdscript__("{0}.replace({1}, {2})", self, what, forwhat);
}
