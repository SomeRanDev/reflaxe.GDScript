package;

import Assert.assert;

class TestString {
	public static function test() {
		var str: String = new String("Test");
		assert(str == "Test");
		assert(str.length == 4);
		assert(str.toString() == "Test");

		assert(String.fromCharCode(70) == "F");
		
		assert(str.charCodeAt(1) == 101);

		assert(str.indexOf("es") == 1);
		assert(str.indexOf("Hey") == -1);
		assert(str.indexOf("Te", 2) == -1);

		assert(str.lastIndexOf("Te") == 0);

		assert(str.split("s")[0] == "Te");
		assert(str.split("e").length == 2);

		var str2 = "Hello, World!";
		assert(str2.substr(7, 5) == "World");
		assert(str2.substring(7, 12) == "World");

		assert(str2.toLowerCase() == "hello, world!");
		assert(str2.toUpperCase() == "HELLO, WORLD!");
	}
}
