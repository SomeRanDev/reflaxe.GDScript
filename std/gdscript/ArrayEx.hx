package gdscript;

/**
	Allows Haxe's `Array`s to use functions from Godot's `Array` type.

	Last updated for Godot 4.4.
**/
class ArrayEx {
	public static extern inline function size<T>(self: Array<T>): Int return untyped __gdscript__("{0}.size()", self);
	public static extern inline function is_empty<T>(self: Array<T>): Bool return untyped __gdscript__("{0}.is_empty()", self);
	public static extern inline function clear<T>(self: Array<T>): Void untyped __gdscript__("{0}.clear()", self);
	public static extern inline function hash<T>(self: Array<T>): Int return untyped __gdscript__("{0}.hash()", self);
	public static extern inline function assign<T>(self: Array<T>, array: Array<T>): Void untyped __gdscript__("{0}.assign({1})", self, array);
	public static extern inline function get<T>(self: Array<T>, index: Int): T return untyped __gdscript__("{0}.get({1})", self, index);
	public static extern inline function set<T>(self: Array<T>, index: Int, value: T) untyped __gdscript__("{0}.set({1}, {2})", self, index, value);
	public static extern inline function push_back<T>(self: Array<T>, value: T): Void untyped __gdscript__("{0}.push_back({1})", self, value);
	public static extern inline function push_front<T>(self: Array<T>, value: T): Void untyped __gdscript__("{0}.push_front({1})", self, value);
	public static extern inline function append<T>(self: Array<T>, value: T): Void untyped __gdscript__("{0}.append({1})", self, value);
	public static extern inline function append_array<T>(self: Array<T>, array: Array<T>): Void untyped __gdscript__("{0}.append_array({1})", self, array);
	public static extern inline function resize<T>(self: Array<T>, size: Int): Int return untyped __gdscript__("{0}.resize({1})", self, size);
	public static extern inline function insert<T>(self: Array<T>, position:Int, value: T): Int return untyped __gdscript__("{0}.insert({1}, {2})", self, position, value);
	public static extern inline function remove_at<T>(self: Array<T>, position: Int): Void untyped __gdscript__("{0}.remove_at({1})", self, position);
	public static extern inline function fill<T>(self: Array<T>, value: T): Void untyped __gdscript__("{0}.fill({1})", self, value);
	public static extern inline function erase<T>(self: Array<T>, value: T): Void untyped __gdscript__("{0}.erase({1})", self, value);
	public static extern inline function front<T>(self: Array<T>): T return untyped __gdscript__("{0}.front()", self);
	public static extern inline function back<T>(self: Array<T>): T return untyped __gdscript__("{0}.back()", self);
	public static extern inline function pick_random<T>(self: Array<T>): T return untyped __gdscript__("{0}.pick_random()", self);
	public static extern inline function find<T>(self: Array<T>, what: T, from: Int = 0): Int return untyped __gdscript__("{0}.find({1}, {2})", self, what, from);
	public static extern inline function find_custom<T>(self: Array<T>, method: (T) -> Bool, from: Int = 0): Int return untyped __gdscript__("{0}.find_custom({1}, {2})", self, method, from);
	public static extern inline function rfind<T>(self: Array<T>, what: Dynamic, from: Int = -1): Int return untyped __gdscript__("{0}.rfind({1}, {2})", self, what, from);
	public static extern inline function rfind_custom<T>(self: Array<T>, method: (T) -> Bool, from: Int = -1): Int return untyped __gdscript__("{0}.rfind_custom({1}, {2})", self, method, from);
	public static extern inline function count<T>(self: Array<T>, value: T): Int return untyped __gdscript__("{0}.count({1})", self, value);
	public static extern inline function has<T>(self: Array<T>, value: T): Bool return untyped __gdscript__("{0}.has({1})", self, value);
	public static extern inline function pop_back<T>(self: Array<T>): T return untyped __gdscript__("{0}.pop_back()", self);
	public static extern inline function pop_front<T>(self: Array<T>): T return untyped __gdscript__("{0}.pop_front()", self);
	public static extern inline function pop_at<T>(self: Array<T>, position: Int): T return untyped __gdscript__("{0}.pop_at({1})", self, position);
	public static extern inline function sort<T>(self: Array<T>): Void untyped __gdscript__("{0}.sort()", self);
	public static extern inline function sort_custom<T>(self: Array<T>, func: (T, T) -> Bool) untyped __gdscript__("{0}.sort_custom({1})", self, func);
	public static extern inline function shuffle<T>(self: Array<T>): Void untyped __gdscript__("{0}.shuffle()", self);
	public static extern inline function bsearch<T>(self: Array<T>, value: Dynamic, before: Bool = true): Int return untyped __gdscript__("{0}.bsearch({1}, {2})", self, value, before);
	public static extern inline function bsearch_custom<T>(self: Array<T>, func: (T) -> Bool, before: Bool = true): Int return untyped __gdscript__("{0}.bsearch_custom({1}, {2})", self, func, before);
	public static extern inline function reverse<T>(self: Array<T>): Void untyped __gdscript__("{0}.reverse()", self);
	public static extern inline function duplicate<T>(self: Array<T>, deep: Bool = false): Array<T> return untyped __gdscript__("{0}.duplicate({1})", self, deep);
	public static extern inline function slice<T>(self: Array<T>, begin: Int, end: Int = 2147483647, step: Int = 1, deep: Bool = false): Array<T> return untyped __gdscript__("{0}.duplicate({1}, {2}, {3}, {4})", self, begin, end, step, deep);
	public static extern inline function filter<T>(self: Array<T>, method: (T) -> Bool): Array<T> return untyped __gdscript__("{0}.filter({1})", self, method);
	public static extern inline function map<T, U>(self: Array<T>, method: (T) -> U): Array<U> return untyped __gdscript__("{0}.map({1})", self, method);
	public static extern inline function reduce<T>(self: Array<T>, method: (T) -> T, ?accum:T): T return untyped __gdscript__("{0}.reduce({1}, {2})", self, method, accum);
	public static extern inline function any<T>(self: Array<T>, method: (T) -> Bool): Bool return untyped __gdscript__("{0}.any({1})", self, method);
	public static extern inline function all<T>(self: Array<T>, method: (T) -> Bool): Bool return untyped __gdscript__("{0}.all({1})", self, method);
	public static extern inline function max<T>(self: Array<T>): T return untyped __gdscript__("{0}.max()", self);
	public static extern inline function min<T>(self: Array<T>): T return untyped __gdscript__("{0}.min()", self);
	public static extern inline function is_typed<T>(self: Array<T>): Bool return untyped __gdscript__("{0}.is_typed()", self);
	public static extern inline function is_same_typed<T>(self: Array<T>, array: Array<T>): Bool return untyped __gdscript__("{0}.is_same_typed({1})", self, array);
	public static extern inline function get_typed_builtin<T>(self: Array<T>): Int return untyped __gdscript__("{0}.get_typed_builtin()", self);
	public static extern inline function get_typed_class_name<T>(self: Array<T>): StringName return untyped __gdscript__("{0}.get_typed_class_name()", self);
	public static extern inline function get_typed_script<T>(self: Array<T>): Dynamic return untyped __gdscript__("{0}.get_typed_script()", self);
	public static extern inline function make_read_only<T>(self: Array<T>): Void untyped __gdscript__("{0}.make_read_only()", self);
	public static extern inline function is_read_only<T>(self: Array<T>): Bool return untyped __gdscript__("{0}.is_read_only()", self);
}
