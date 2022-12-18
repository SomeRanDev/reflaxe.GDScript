package;

import haxe.iterators.ArrayKeyValueIterator;

@:coreApi
extern class Array<T> {
	// ----------------------------
	// Haxe String Functions
	// ----------------------------

	@:nativeName("size()")
	public var length(default, null): Int;

	// ----------
	// constructor
	@:nativeFunctionCode("[]")
	public function new();

	@:nativeFunctionCode("{this} + {arg0}")
	public function concat(a: Array<T>): Array<T>;

	public extern inline function join(sep: String): String {
		var result: String = "";
		final len = length;
		for(i in 0...len) {
			result += Std.string(get(i)) + (i == len - 1 ? "" : sep);
		}
		return result;
	}

	@:nativeFunctionCode("{this}[{arg0}]")
	private function get(index: Int): T;

	@:nativeName("pop_back")
	public function pop(): Null<T>;

	@:nativeName("push_back")
	public function push(x: T): Int;

	@:nativeName("reverse")
	public function reverse(): Void;

	@:nativeName("pop_front")
	public function shift(): Null<T>;

	@:nativeName("slice")
	public function slice(pos: Int, end: Int = 2147483647):Array<T>;

	@:nativeName("sort_custom")
	public function sort(f: (T, T) -> Int): Void;

	public extern inline function splice(pos: Int, len: Int): Array<T> {
		final result = [];
		var i = pos + len;
		if(pos < 0) pos = 0;
		if(i >= length) i = length - 1;
		while(i >= pos) {
			result.push(get(i));
			removeAt(i);
			i++;
		}
		return result;
	}

	@:nativeName("remove_at")
	private function removeAt(pos: Int): Void;

	@:native("str({this})")
	public function toString(): String;

	@:nativeName("push_front")
	public function unshift(x: T): Void;

	@:nativeName("insert")
	public function insert(pos: Int, x: T): Void;

	@:nativeName("erase")
	public function remove(x: T): Bool;

	@:nativeName("has")
	@:pure public function contains(x : T): Bool;

	@:nativeName("find")
	public function indexOf(x: T, fromIndex: Int = 0): Int;

	@:nativeName("rfind")
	public function lastIndexOf(x: T, fromIndex: Int = -1): Int;

	public extern inline function copy(): Array<T> {
		return [for (v in this) v];
	}

	@:runtime inline function iterator(): haxe.iterators.ArrayIterator<T> {
		return new haxe.iterators.ArrayIterator(this);
	}

	@:pure @:runtime public inline function keyValueIterator() : ArrayKeyValueIterator<T> {
		return new ArrayKeyValueIterator(this);
	}

	@:runtime inline function map<S>(f: (T) -> S):Array<S> {
		return [for (v in this) f(v)];
	}

	@:runtime inline function filter(f: (T) -> Bool):Array<T> {
		return [for (v in this) if(f(v)) v];
	}

	@:nativeName("resize")
	public function resize(len: Int): Void;
}
