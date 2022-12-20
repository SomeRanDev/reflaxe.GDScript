package;

@:native("assert")
extern function godot_assert(cond: Bool, errMsg: Null<String> = null);

extern inline function assert(cond: Bool, errMsg: String = "Test assert failed.") {
	godot_assert(cond, errMsg);
}

extern inline function assertFloat(input: Float, actual: Float, errMsg: String = "Test assert failed.") {
	godot_assert(Math.abs(actual - input) < 0.0001, errMsg);
}
