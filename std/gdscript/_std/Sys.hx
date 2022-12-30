package;

@:require(sys)
extern class Sys {
	@:runtime public inline static function print(v: Dynamic): Void {
		untyped __gdscript__("print(str({}))", v);
	}

	@:runtime public inline static function println(v: Dynamic): Void {
		untyped __gdscript__("print(str({}) + \"\n\")", v);
	}

	@:runtime public inline static function args(): Array<String> {
		return [];
	}

	@:runtime public inline static function getEnv(s: String): String {
		return untyped __gdscript__("OS.get_environment({})", s);
	}

	@:runtime public inline static function putEnv(s: String, v: Null<String>): Void {
		return untyped __gdscript__("OS.set_environment({}, {})", s, v == null ? "" : v);
	}

	@:runtime public inline static function environment(): Map<String, String> {
		throw "Sys.environment not implemented for GDScript.";
	}

	@:runtime public inline static function sleep(seconds: Float): Void {
		untyped __gdscript__("OS.delay_msec({} * 1000)", seconds);
	}

	@:runtime public inline static function setTimeLocale(loc: String): Bool {
		return false;
	}

	@:runtime public inline static function getCwd(): String {
		return programPath();
	}

	@:runtime public inline static function setCwd(s: String): Void {
		throw "Sys.setCwd not implemented for GDScript.";
	}

	@:runtime public inline static function systemName(): String {
		return switch untyped __gdscript__("OS.get_name()") {
			case "macOS": "Mac";
			case "FreeBSD" | "NetBSD" | "OpenBSD": "BSD";
			case s: s;
		}
	}

	@:runtime public inline static function command(cmd: String, ?args: Array<String>): Int {
		if(args == null) args = [];
		return untyped __gdscript__("OS.execute({}, PackedStringArray({}))", cmd, args);
	}

	@:runtime public inline static function exit(code: Int): Void {
		throw "Sys.exit not implemented for GDScript.";
	}

	@:runtime public inline static function time(): Float {
		throw "Sys.time not implemented for GDScript.";
	}

	@:runtime public inline static function cpuTime(): Float {
		return untyped __gdscript__("(Time.get_ticks_msec() * 1000)");
	}

	@:deprecated("Use programPath instead")
	@:runtime public inline static function executablePath(): String {
		return programPath();
	}

	@:runtime public inline static function programPath(): String {
		return untyped __gdscript__("OS.get_executable_path()");
	}

	@:runtime public inline static function getChar(echo: Bool): Int {
		throw "Sys.getChar not implemented for GDScript.";
	}

	@:runtime public inline static function stdin(): haxe.io.Input {
		throw "Sys.stdin not implemented for GDScript.";
	}

	@:runtime public inline static function stdout(): haxe.io.Output {
		throw "Sys.stdout not implemented for GDScript.";
	}

	@:runtime public inline static function stderr(): haxe.io.Output {
		throw "Sys.stderr not implemented for GDScript.";
	}
}