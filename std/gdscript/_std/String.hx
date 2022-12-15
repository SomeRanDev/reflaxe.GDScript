package;

@:coreApi
extern class String {
	// ----------------------------
	// Haxe String Functions
	// ----------------------------

	// ----------
	// constructor
	public function new(string: String);

	// ----------
	// @:nativeName
	@:nativeName("length()")
	public var length(default, null): Int;

	@:nativeName("to_upper")
	public function toUpperCase(): String;

	@:nativeName("to_lower")
	public function toLowerCase(): String;

	@:nativeName("find")
	public function indexOf(str: String, startIndex: Int = 0): Int;
	
	@:nativeName("substr")
	public function substr(pos: Int, len: Int = -1): String;

	// ----------
	// @:native
	@:native("char")
	public static function fromCharCode(code: Int): String;

	// ----------
	// @:nativeFunctionCode
	@:nativeFunctionCode("{this}[{arg0}]")
	public function charAt(index: Int): String;

	@:nativeFunctionCode("{this}")
	public function toString(): String;

	// ----------
	// extern inline
	public extern inline function charCodeAt(index: Int): Null<Int> {
		return if(index >= 0 && index < length) {
			ordAt(index);
		} else {
			null;
		}
	}

	public extern inline function lastIndexOf(str: String, startIndex: Int = -1): Int {
		return if(startIndex < 0) {
			findLast(str);
		} else {
			substring(0, startIndex).findLast(str);
		}
	}

	public extern inline function split(delimiter: String): Array<String> {
		return untyped __gdscript__("Array({}.split({}))", this, delimiter);
	}

	public extern inline function substring(startIndex: Int, endIndex: Int = -1): String {
		return if(endIndex < 0) {
			substr(startIndex);
		} else {
			substr(startIndex, endIndex - startIndex);
		}
	}

	// ----------------------------
	// GDScript String Functions
	//
	// (gotta keep these private cause @:coreApi requires all 
	//  fields that don't match the api to be explicitly private).
	// ----------------------------
	@:native("ord_at") private function ordAt(at: Int): Int;
	@:native("find_last") private function findLast(what: String): Int;
	@:native("findn") private function findNoCase(what: String, from: Int = 0): Int;
	@:native("length") private function getLength(): Int;
}
