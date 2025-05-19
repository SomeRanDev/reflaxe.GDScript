package test;

import Assert.assert;

class TestMap {
	public static function test() {
		// String
		var map = new Map();
		assert(map.exists("foo") == false);
		assert(map.get("foo") == null);
		map.set("foo", 1);
		map.set("bar", 2);
		map.set("baz", 3);
		var dynmap:Dynamic = map;
		var map2:haxe.Constraints.IMap<Dynamic,Dynamic> = dynmap;
		var map3:haxe.Constraints.IMap<String, Dynamic> = dynmap;
		var map4:haxe.Constraints.IMap<String, Int> = dynmap;
		assert((map is haxe.ds.StringMap) == true);
		assert(map.exists("foo") == true);
		assert(map.exists("bar") == true);
		assert(map.exists("baz") == true);
		assert(map.get("foo") == 1);
		assert(map.get("bar") == 2);
		assert(map.get("baz") == 3);
		assert(map2.exists("foo") == true);
		assert(map2.get("foo") == 1);
		assert(map3.exists("foo") == true);
		assert(map3.get("foo") == 1);
		assert(map4.exists("foo") == true);
		assert(map4.get("foo") == 1);

		var copied = map.copy();
		assert(copied != map);
		assert(copied.exists("foo") == map.exists("foo"));
		assert(copied.exists("bar") == map.exists("bar"));
		assert(copied.exists("baz") == map.exists("baz"));
		assert(copied.get("foo") == map.get("foo"));
		assert(copied.get("bar") == map.get("bar"));
		assert(copied.get("baz") == map.get("baz"));

		copied.set("foo", 4);
		assert(copied.get("foo") == 4);
		assert(map.get("foo") == 1);

		var values = [];
		for (val in map) {
			values.push(val);
		}
		assert(values.length == 3);
		assert([1, 2, 3].contains(values[0]));
		assert([1, 2, 3].contains(values[1]));
		assert([1, 2, 3].contains(values[2]));
		var keys = ["foo", "bar", "baz"];
		for (key in map.keys()) {
			assert(keys.remove(key));
		}
		assert(keys == []);
		assert(map.remove("bar") == true);
		assert(map.remove("bar") == false);
		assert(map.exists("foo") == true);
		assert(map.exists("bar") == false);
		assert(map.exists("baz") == true);
		assert(map.get("bar") == null);

		var map3 = [1=>"2",2=>"4",3=>"6"];
		var keys = [for (k=>v in map3) k];
		keys.sort(Reflect.compare);
		assert(keys == [1,2,3]);
		var values = [for (k=>v in map3) v];
		values.sort(Reflect.compare);
		assert(values == ["2","4","6"]);


		// Int
		var map = new Map();
		assert(map.exists(1) == false);
		assert(map.get(1) == null);
		map.set(1, 1);
		map.set(2, 2);
		map.set(3, 3);
		assert((map is haxe.ds.IntMap) == true);
		assert(map.exists(1) == true);
		assert(map.exists(2) == true);
		assert(map.exists(3) == true);
		assert(map.get(1) == 1);
		assert(map.get(2) == 2);
		assert(map.get(3) == 3);

		var copied = map.copy();
		assert(copied != map);
		assert(copied.exists(1) == map.exists(1));
		assert(copied.exists(2) == map.exists(2));
		assert(copied.exists(3) == map.exists(3));
		assert(copied.get(1) == map.get(1));
		assert(copied.get(2) == map.get(2));
		assert(copied.get(3) == map.get(3));

		copied.set(1, 4);
		assert(copied.get(1) == 4);
		assert(map.get(1) == 1);

		var values = [];
		for (val in map) {
			values.push(val);
		}
		assert(values.length == 3);
		assert([1, 2, 3].contains(values[0]));
		assert([1, 2, 3].contains(values[1]));
		assert([1, 2, 3].contains(values[2]));
		var keys = [1, 2, 3];
		for (key in map.keys()) {
			assert(keys.remove(key));
		}
		assert(keys == []);
		assert(map.remove(2) == true);
		assert(map.remove(2) == false);
		assert(map.exists(1) == true);
		assert(map.exists(2) == false);
		assert(map.exists(3) == true);
		assert(map.get(2) == null);

		var map3 = [1=>2,2=>4,3=>6];
		var keys = [for (k=>v in map3) k];
		keys.sort(Reflect.compare);
		assert(keys == [1,2,3]);
		var values = [for (k=>v in map3) v];
		values.sort(Reflect.compare);
		assert(values == [2,4,6]);

		// Hashable
		var map = new Map();
		var a = new test.MyAbstract.ClassWithHashCode(1);
		var b = new test.MyAbstract.ClassWithHashCode(2);
		var c = new test.MyAbstract.ClassWithHashCode(3);
		assert(map.exists(a) == false);
		assert(map.get(a) == null);
		map.set(a, 1);
		map.set(b, 2);
		map.set(c, 3);
		assert(map.exists(a) == true);
		assert(map.exists(b) == true);
		assert(map.exists(c) == true);
		assert(map.get(a) == 1);
		assert(map.get(b) == 2);
		assert(map.get(c) == 3);

		var keys = [for (k=>v in map) k];
		assert([a,b,c].contains(keys[0]));
		assert([a,b,c].contains(keys[1]));
		assert([a,b,c].contains(keys[2]));
		var values = [for (k=>v in map) v];
		assert([1,2,3].contains(values[0]));
		assert([1,2,3].contains(values[1]));
		assert([1,2,3].contains(values[2]));

		var copied = map.copy();
		assert(copied != map);
		assert(copied.exists(a) == map.exists(a));
		assert(copied.exists(b) == map.exists(b));
		assert(copied.exists(c) == map.exists(c));
		assert(copied.get(a) == map.get(a));
		assert(copied.get(b) == map.get(b));
		assert(copied.get(c) == map.get(c));

		copied.set(a, 4);
		assert(copied.get(a) == 4);
		assert(map.get(a) == 1);

		var values = [];
		for (val in map) {
			values.push(val);
		}
		assert(values.length == 3);
		assert([1, 2, 3].contains(values[0]));
		assert([1, 2, 3].contains(values[1]));
		assert([1, 2, 3].contains(values[2]));
		var keys = [a, b, c];
		for (key in map.keys()) {
			assert(keys.remove(key));
		}
		assert(keys == []);
		assert(map.remove(b) == true);
		assert(map.remove(b) == false);
		assert(map.exists(a) == true);
		assert(map.exists(b) == false);
		assert(map.exists(c) == true);
		assert(map.get(b) == null);

		// Object
		var map = new Map();
		var a = new test.MyAbstract.ClassWithoutHashCode(1);
		var b = new test.MyAbstract.ClassWithoutHashCode(2);
		var c = new test.MyAbstract.ClassWithoutHashCode(3);
		assert(map.exists(a) == false);
		assert(map.get(a) == null);
		map.set(a, 1);
		map.set(b, 2);
		map.set(c, 3);
		assert(map.exists(a) == true);
		assert(map.exists(b) == true);
		assert(map.exists(c) == true);
		assert(map.get(a) == 1);
		assert(map.get(b) == 2);
		assert(map.get(c) == 3);

		var keys = [for (k=>v in map) k];
		assert([a,b,c].contains(keys[0]));
		assert([a,b,c].contains(keys[1]));
		assert([a,b,c].contains(keys[2]));
		var values = [for (k=>v in map) v];
		assert([1,2,3].contains(values[0]));
		assert([1,2,3].contains(values[1]));
		assert([1,2,3].contains(values[2]));

		var copied = map.copy();
		assert(copied != map);
		assert(copied.exists(a) == map.exists(a));
		assert(copied.exists(b) == map.exists(b));
		assert(copied.exists(c) == map.exists(c));
		assert(copied.get(a) == map.get(a));
		assert(copied.get(b) == map.get(b));
		assert(copied.get(c) == map.get(c));

		copied.set(a, 4);
		assert(copied.get(a) == 4);
		assert(map.get(a) == 1);

		var values = [];
		for (val in map) {
			values.push(val);
		}
		assert(values.length == 3);
		assert([1, 2, 3].contains(values[0]));
		assert([1, 2, 3].contains(values[1]));
		assert([1, 2, 3].contains(values[2]));
		var keys = [a, b, c];
		for (key in map.keys()) {
			assert(keys.remove(key));
		}
		assert(keys == []);
		assert(map.remove(b) == true);
		assert(map.remove(b) == false);
		assert(map.exists(a) == true);
		assert(map.exists(b) == false);
		assert(map.exists(c) == true);
		assert(map.get(b) == null);

		// [] access
		var map = new Map();
		assert(map["foo"] == null);
		map["foo"] = 12;
		assert(map.get("foo") == 12);
		assert(map["foo"] == 12);
		map["foo"] += 2;
		assert(map.get("foo") == 14);
		assert(map["foo"] == 14);
		map["foo"] *= map["foo"] + 2;
		assert(map["foo"] == 224);
		map["f" + "o" + "o"] -= 223;
		assert(map[(function(s) return s + "o")("fo")] == 1);
		map["bar"] = map["foo"] = 9;
		assert(map["bar"] == 9);
		assert(map["foo"] == 9);

		assert(['' => ''].keys().next() == '');
		assert(['' => ''].iterator().next() == '');
		assert([2 => 3].keys().next() == 2);
		assert([2 => 3].iterator().next() == 3);
		//[a => b].keys().next() == a);
		//[a => b].iterator().next() == b);

		var map:Map<String, Int>;
		HelperMacros.typedAs((null : Map<String, Int>), map = []);
		assert(HelperMacros.typeError(map[1] = 1) == true);

		assert(['' => ''].keyValueIterator().next().key == '');
		assert(['' => ''].keyValueIterator().next().value == '');
		assert([2 => 3].keyValueIterator().next().key == 2);
		assert([2 => 3].keyValueIterator().next().value == 3);

		// Test unification

		var map = [1=>"2",2=>"4"];
		var iterable:KeyValueIterable<Int, String> = map;
		var values = [for(kv in iterable.keyValueIterator()) kv.value];
		assert(["2","4"].contains(values[0]));
		assert(["2","4"].contains(values[1]));

		var iterator:KeyValueIterator<Int,String> = iterable.keyValueIterator();
		var keys = [for(kv in iterator) kv.key];
		assert([1,2].contains(keys[0]));
		assert([1,2].contains(keys[1]));


		// Test through Dynamic

		var map = [1=>"2",2=>"4"];
		var dyn:Dynamic = map;
		var it = dyn.iterator();
		var it:Iterator<String> = cast it;
		var values = [for(v in it) v];
		assert(["2","4"].contains(values[0]));
		assert(["2","4"].contains(values[1]));

		var it = dyn.keyValueIterator();
		var it:KeyValueIterator<Int,String> = cast it;
		var values = [for(kv in it) kv.value];
		assert(["2","4"].contains(values[0]));
		assert(["2","4"].contains(values[1]));
		var it = dyn.keyValueIterator();
		var it:KeyValueIterator<Int,String> = cast it;
		var keys = [for(kv in it) kv.key];
		assert([1,2].contains(keys[0]));
		assert([1,2].contains(keys[1]));


		var map = ["1a"=>"2","1b"=> "4"];
		var dyn:Dynamic = map;
		var it = dyn.iterator();
		var it:Iterator<String> = cast it;
		var values = [for(v in it) v];
		assert(["2","4"].contains(values[0]));
		assert(["2","4"].contains(values[1]));

		var it = dyn.keyValueIterator();
		var it:KeyValueIterator<String,String> = cast it;
		var values = [for(kv in it) kv.value];
		assert(["2","4"].contains(values[0]));
		assert(["2","4"].contains(values[1]));

		var it = dyn.keyValueIterator();
		var it:KeyValueIterator<String,String> = cast it;
		var keys = [for(kv in it) kv.key];
		assert(["1a","1b"].contains(keys[0]));
		assert(["1a","1b"].contains(keys[1]));
	}
}