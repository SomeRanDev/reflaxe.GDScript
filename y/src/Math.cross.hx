package;

extern class Math {
	public static var PI(get, never): Float;
	@:runtime public static inline function get_PI(): Float return untyped __gdscript__("PI");

	@:native("-INF")
	public static var NEGATIVE_INFINITY(default, null): Float;

	@:native("INF")
	public static var POSITIVE_INFINITY(default, null): Float;

	public static var NaN(get, never): Float;
	@:runtime public static inline function get_NaN(): Float return untyped __gdscript__("NAN");

	@:native("abs") public static function abs(v: Float): Float;
	@:native("min") public static function min(a: Float, b: Float): Float;
	@:native("max") public static function max(a: Float, b: Float): Float;

	@:native("sin") public static function sin(v: Float): Float;
	@:native("cos") public static function cos(v: Float): Float;
	@:native("tan") public static function tan(v: Float): Float;
	@:native("asin") public static function asin(v: Float): Float;
	@:native("acos") public static function acos(v: Float): Float;
	@:native("atan") public static function atan(v: Float): Float;

	@:native("atan2") public static function atan2(y: Float, x: Float): Float;

	@:native("exp") public static function exp(v: Float): Float;
	@:native("log") public static function log(v: Float): Float;

	@:native("pow") public static function pow(v: Float, exp: Float): Float;

	@:native("sqrt") public static function sqrt(v: Float): Float;

	@:runtime public static inline function round(v: Float): Int return Std.int(fround(v));
	@:runtime public static inline function floor(v: Float): Int return Std.int(ffloor(v));
	@:runtime public static inline function ceil(v: Float): Int return Std.int(fceil(v));

	@:native("round") public static function fround(v: Float): Float;
	@:native("floor") public static function ffloor(v: Float): Float;
	@:native("ceil") public static function fceil(v: Float): Float;

	@:native("randf") public static function random(): Float;

	@:native("is_nan") public static function isNaN(f: Float): Bool;

	@:native("is_finite") public static function isFinite(f: Float): Bool;
}
