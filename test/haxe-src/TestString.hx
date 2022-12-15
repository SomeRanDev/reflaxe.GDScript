package;

class TestString {
	public static function test() {

		var str: String = new String("Test");
		trace(str);

		var str2 = String.fromCharCode(65 + Math.floor(Math.random()));
		trace(str2);
		
		var fd = str.length;
		str2.charAt(43);
	}
}
