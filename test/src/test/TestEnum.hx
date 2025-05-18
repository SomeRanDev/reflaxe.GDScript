package test;

import Assert.assert;

enum MyGDEnum {
	Rock;
	Paper;
	Scissors;
}

enum MyDictEnum {
	Entry1;
	Entry2(i: Int);
	Entry3(s: String);
}

class TestEnum {
	static function isLeftWinner(left: MyGDEnum, right: MyGDEnum) {
		return switch(left) {
			case Rock: right == Scissors;
			case Paper: right == Rock;
			case Scissors: right == Paper;
		}
	}

	public static function test() {
		assert(isLeftWinner(Paper, Rock));
		assert(!isLeftWinner(Rock, Paper));
		assert(!isLeftWinner(Scissors, Scissors));

		final a = Entry1;
		final b = Entry2(123);
		final c = Entry3("Test");

		switch(b) {
			case Entry1: assert(false);
			case Entry2(i): assert(i == 123);
			case Entry3(s): assert(false);
		}

		switch(c) {
			case Entry1: assert(false);
			case Entry2(i): assert(false);
			case Entry3(s): assert(s == "Test");
		}
	}
}
