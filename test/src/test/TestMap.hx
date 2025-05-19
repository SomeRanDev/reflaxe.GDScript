package test;

import Assert.assert;

class TestMap {
	public static function test() {
		// constructor
		final m = new Map<String, Int>();
		final m2 = [123 => "123", 321 => "321"];

		// set
		m.set("a", 1);
		m["b"] = 2;

		// get
		assert(m.get("a") == 1);
		assert(m["b"] == 2);
		assert(m2[321] == "321");

		// copy
		final m3 = m.copy();
		assert(m3.get("a") == 1);
		assert(m3["b"] == 2);

		// clear
		m3.clear();
		assert(!m3.exists("a"));

		// exists
		assert(m.exists("a"));
		assert(!m.exists("c"));
		assert(m2.exists(123));
		assert(!m2.exists(124));

		// remove
		m.remove("a");
		assert(!m.exists("a"));

		// toString
		trace(m.toString());
	}
}