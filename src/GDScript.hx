package;

/**
	Builtin GDScript constants, functions, and annotations.
	https://docs.godotengine.org/en/stable/classes/class_%40gdscript.html

	These are not covered in `extension_api.json`.

	However, some functions will require Godot externs to be available and
	under the "godot" package.

	TODO: Complete this!!
**/
extern class GDScript {
	@:native("load")
	public static function load(path: String): #if has_godot_externs godot.Resource #else Dynamic #end;

	@:native("preload")
	public static function preload(path: String): #if has_godot_externs godot.Resource #else Dynamic #end;

	@:native("type_exists")
	public static function typeExists(type: #if has_godot_externs godot.StringName #else String #end): Bool;
}
