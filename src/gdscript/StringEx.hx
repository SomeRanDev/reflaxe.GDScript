package gdscript;

/**
	Allows Haxe's `String`s to use functions from Godot's `String` type.

	Last updated for Godot 4.4.
**/
class StringEx {
	public static extern inline function replace(self: String, what: String, forwhat: String): String return untyped __gdscript__("{0}.replace({1}, {2})", self, what, forwhat);

	// Requires the Godot API bindings to be generated...
	#if godot_api
	public static extern inline function join(self: String, parts: godot.PackedStringArray): String return untyped __gdscript__("{0}.join({1})", self, parts);
	#end
}
