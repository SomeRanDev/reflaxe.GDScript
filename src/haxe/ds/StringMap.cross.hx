package haxe.ds;

class StringMap<T> implements haxe.Constraints.IMap<String, T> {
	var m: gdscript.Dictionary<String, T>;

	public function new(): Void {
		m = new gdscript.Dictionary<String, T>();
	}

	public function set(key: String, value: T): Void {
		m.set(key, value);
	}

	public function get(key: String): Null<T> {
		return if(m.has(key)) {
			m.get(key);
		} else {
			null;
		}
	}

	public function exists(key: String): Bool {
		return m.has(key);
	}

	public function remove(key: String): Bool {
		return m.erase(key);
	}

	public function keys(): Iterator<String> {
		return m.keys().iterator();
	}

	public function iterator(): Iterator<T> {
		return m.values().iterator();
	}

	@:runtime public inline function keyValueIterator(): KeyValueIterator<String, T> {
		return new haxe.iterators.MapKeyValueIterator(this);
	}

	public function copy(): StringMap<T> {
		final result = new StringMap<T>();
		result.m = m.duplicate(false);
		return result;
	}

	public function toString(): String {
		var result = "[";
		var first = true;
		for(key => value in this) {
			result += (first ? "" : ", ") + (Std.string(key) + " => " + Std.string(value));
			if(first) first = false;
		}
		return result + "]";
	}

	public function clear(): Void {
		m.clear();
	}
}