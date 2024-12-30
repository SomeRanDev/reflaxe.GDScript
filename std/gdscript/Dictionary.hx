package gdscript;

/**
	Godot's typed Dictionary type.

	For using `Dictionary` without type arguments, use `gdscript.UntypedDictionary`.

	Last updated for Godot 4.4.
**/
@:forward
@:forward.new
@:forwardStatics
@:copyType
@:nativeTypeCode("Dictionary<{type0}, {type1}>")
extern abstract Dictionary<KeyType, ValueType>(Dictionary_Fields<KeyType, ValueType>) {
	@:arrayAccess public inline function arrayAccessGet(key: String): Dynamic { return untyped __gdscript__("({0}[{1}])", this, key); }
	@:arrayAccess public inline function arrayAccessSet(key: String, value: Dynamic): Dynamic {
		untyped __gdscript__("({0}[{1}] = {2})", this, key, value);
		return value;
	}

	@:op(!A)     public static inline function not<KeyType, ValueType>   (self: Dictionary<KeyType, ValueType>): Bool return untyped __gdscript__("(!{0})", self);
	@:op(A == B) public static inline function eq<KeyType, ValueType>    (self: Dictionary<KeyType, ValueType>, other: Dynamic): Bool return untyped __gdscript__("(({0}) == ({1}))", self, other);
	@:op(A != B) public static inline function notEq<KeyType, ValueType> (self: Dictionary<KeyType, ValueType>, other: Dynamic): Bool return untyped __gdscript__("(({0}) != ({1}))", self, other);
	@:op(A == B) public static inline function eq2<KeyType, ValueType>   (self: Dictionary<KeyType, ValueType>, other: Dictionary<KeyType, ValueType>): Bool return untyped __gdscript__("(({0}) == ({1}))", self, other);
	@:op(A != B) public static inline function notEq2<KeyType, ValueType>(self: Dictionary<KeyType, ValueType>, other: Dictionary<KeyType, ValueType>): Bool return untyped __gdscript__("(({0}) != ({1}))", self, other);
	@:op(A in B) public static inline function inOp<KeyType, ValueType>  (self: Dictionary<KeyType, ValueType>, other: Dictionary<KeyType, ValueType>): Bool return untyped __gdscript__("(({0}) in ({1}))", self, other);
	@:op(A in B) public static inline function inOp2<KeyType, ValueType> (self: Dictionary<KeyType, ValueType>, other: Array<KeyType>): Bool return untyped __gdscript__("(({0}) in ({1}))", self, other);
}

@:noCompletion
@:copyType
@:avoid_temporaries
@:nativeTypeCode("Dictionary<{type0}, {type1}>")
extern class Dictionary_Fields<KeyType, ValueType> {
	@:overload(function(from: Dictionary<KeyType, ValueType>): Void { })
	@:overload(function(base: Dictionary<KeyType, ValueType>, key_type: Int, key_class_name: StringName, key_script: Dynamic, value_type: Int, value_class_name: StringName, value_script: Dynamic): Void { })
	public function new();
	public function size(): Int;
	public function is_empty(): Bool;
	public function clear(): Void;
	public function assign(dictionary: Dictionary<KeyType, ValueType>): Void;
	public function sort(): Void;
	public function merge(dictionary: Dictionary<KeyType, ValueType>, overwrite: Bool = false): Void;
	public function merged(dictionary: Dictionary<KeyType, ValueType>, overwrite: Bool = false): Dictionary<KeyType, ValueType>;
	public function has(key: Dynamic): Bool;
	public function has_all(keys: Array<KeyType>): Bool;
	public function find_key(value: Dynamic): Dynamic;
	public function erase(key: Dynamic): Bool;
	public function hash(): Int;
	public function keys(): Array<KeyType>;
	public function values(): Array<ValueType>;
	public function duplicate(deep: Bool = false): Dictionary<KeyType, ValueType>;
	public function get(key: Dynamic, ?default_value: Dynamic): Dynamic;
	public function get_or_add(key: Dynamic, ?default_value: Dynamic): Dynamic;
	public function set(key: Dynamic, value: Dynamic): Bool;
	public function is_typed(): Bool;
	public function is_typed_key(): Bool;
	public function is_typed_value(): Bool;
	public function is_same_typed(dictionary: Dictionary<KeyType, ValueType>): Bool;
	public function is_same_typed_key(dictionary: Dictionary<KeyType, ValueType>): Bool;
	public function is_same_typed_value(dictionary: Dictionary<KeyType, ValueType>): Bool;
	public function get_typed_key_builtin(): Int;
	public function get_typed_value_builtin(): Int;
	public function get_typed_key_class_name(): StringName;
	public function get_typed_value_class_name(): StringName;
	public function get_typed_key_script(): Dynamic;
	public function get_typed_value_script(): Dynamic;
	public function make_read_only(): Void;
	public function is_read_only(): Bool;
	public function recursive_equal(dictionary: Dictionary<KeyType, ValueType>, recursion_count: Int): Bool;
}