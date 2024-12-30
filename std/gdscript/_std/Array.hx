package;

import haxe.iterators.ArrayKeyValueIterator;

@:coreApi
@:nativeTypeCode("Array[{type0}]")
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

	@:nativeFunctionCode("({this} + {arg0})")
	public function concat(a: Array<T>): Array<T>;

	@:runtime public inline function join(sep: String): String {
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

	@:runtime public inline function sort(f: (T, T) -> Int): Void {
		sortCustom(function(a, b) return f(a, b) < 0);
	}

	@:nativeName("sort_custom")
	private function sortCustom(f: (T, T) -> Bool): Void;

	@:runtime public inline function splice(pos: Int, len: Int): Array<T> {
		final result = [];
		if(pos < 0) pos = 0;
		var i = pos + len - 1;
		if(i >= length) i = length - 1;
		while(i >= pos) {
			result.push(get(pos));
			removeAt(pos);
			i--;
		}
		return result;
	}

	@:nativeName("remove_at")
	private function removeAt(pos: Int): Void;

	@:nativeFunctionCode("str({this})")
	public function toString(): String;

	@:nativeName("push_front")
	public function unshift(x: T): Void;

	@:nativeName("insert")
	private function gdInsert(pos: Int, x: T): Void;

	@:runtime public inline function insert(pos: Int, x: T): Void {
		return (pos < 0) ? gdInsert(length + 1 + pos, x) : gdInsert(pos, x);
	}

	@:runtime public inline function remove(x: T): Bool {
		final index = indexOf(x);
		return if(index >= 0) {
			removeAt(index);
			true;
		} else {
			false;
		}
	}

	@:nativeName("has")
	@:pure public function contains(x : T): Bool;

	@:nativeName("find")
	public function indexOf(x: T, fromIndex: Int = 0): Int;

	@:nativeName("rfind")
	public function lastIndexOf(x: T, fromIndex: Int = -1): Int;

	@:runtime public inline function copy(): Array<T> {
		return [for (v in this) v];
	}

	@:runtime inline function iterator(): haxe.iterators.ArrayIterator<T> {
		return new haxe.iterators.ArrayIterator(this);
	}

	@:pure @:runtime public inline function keyValueIterator() : ArrayKeyValueIterator<T> {
		return new ArrayKeyValueIterator(this);
	}

	@:runtime inline function map<S>(f: (T) -> S):Array<S> {
		final temp = f;
		final result = [];
		for (v in this) result.push(temp(v));
		return result;
	}

	@:runtime inline function filter(f: (T) -> Bool):Array<T> {
		final temp = f;
		final result = [];
		for (v in this) if(temp(v)) result.push(v);
		return result;
	}

	@:nativeName("resize")
	public function resize(len: Int): Void;
}
