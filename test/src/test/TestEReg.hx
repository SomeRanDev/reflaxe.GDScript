package test;

import Assert.assert;

// matchedLeft, matchedRight, map, and escape unimplemented due to laziness
class TestEReg {
	public static function test() {
		final reg = ~/abc/;

		assert(reg.match("abcdef"));

		assert(reg.matched(0) == "abc");

		final pos = reg.matchedPos();
		assert(pos.pos == 0);
		assert(pos.len == 3);

		assert(~/abc/.matchSub("abcabc", 1));

		assert(~/\s*,\s*/.split("one,two ,three, four") == ["one", "two", "three", "four"]);

		assert(reg.replace("123abc", "456") == "123456");
	}
}
