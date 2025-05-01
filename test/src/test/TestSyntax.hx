package test;

import Assert.assert;

class TestSyntax {
	var testField = 123;

	public function new() {
		assert(testField == 123);
	}

	@:dce(Off)
	public static function test() {
		assert(true);
		assert(!false);
		assert(1 + 1 == 2);
		assert(1 - 1 == 0);
		assert(2 * 2 == 4);
		assert(10 / 2 == 5);

		final myNull = null;
		assert(myNull == null);

		final obj = new TestSyntax();
		assert(obj == obj);
		assert(obj.testField == 123);

		var str = "Hello";
		str = "World";
		str = "Hello, " + str;
		str += "!";
		assert(str == "Hello, World!");

		if(str != "Goodbye World!") {
			var num = 3;
			assert(num > 1);
			assert(num >= 3 && num >= 2);
			assert(num == 3);
			assert(num <= 3 && num <= 6);
			assert(num < 4);
		} else {
			assert(false);
		}

		var num = 3;
		assert((num & 1) == 1);
		assert((num & 4) == 0);
		assert((num | 8) == 11);
		assert((num | 3) == 3);

		assert((1 + 1) == 1 + 1);

		final dict: Dynamic = {
			hey: "Hey",
			thing: obj,
			number: 3
		};

		assert(dict.hey == "Hey");
		assert(dict.number == 3);

		dict.pokemon = "Pikachu";
		assert(dict.pokemon == "Pikachu");

		final arr = [1, 2, 3];
		assert(arr[1] == 2);
		assert(arr.length == 3);

		final arr2: Array<Int> = untyped __gdscript__("[]");
		//arr2.push(12);
		//arr2.push(24);
		//assert(arr2[1] == 24);

		final bool = true;
		assert(!!bool);

		var mutNum = 1000;
		mutNum++;
		mutNum++;
		assert(mutNum++ == 1002);
		assert(--mutNum == 1002);
		assert(--mutNum == 1001);
		assert(mutNum == 1001);

		final myFunc = function() {
			mutNum++;
		}
		myFunc();
		myFunc();
		assert(mutNum == 1003);

		final blockVal = {
			final a = 2;
			a * a;
		}
		assert(blockVal == 4);

		if(blockVal == 4) {
			assert(true);
		} else {
			assert(false);
		}

		var i = 0;
		while(i++ < 1000) {
			if(i == 800) {
				assert((i / 80) == 10);
			}
		}

		var j = 0;
		while(j < {
			assert(true);
			6;
		}) {
			assert(true);
			j++;
		}

		var anotherNum = 0;
		var anotherNum2 = anotherNum = 3;
		assert(anotherNum == anotherNum2);

		anotherNum2 = anotherNum += 10;
		assert(anotherNum == anotherNum2);

		@:await untyped __gdscript__("get_tree().create_timer(1.0).timeout");
	}
}
