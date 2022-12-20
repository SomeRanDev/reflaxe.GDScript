package;

class TestAll {
	public static function test() {
		TestSyntax.test();
		TestMath.test();
		TestStd.test();
		TestString.test();
		TestStaticVar.test();
		TestArray.test();

		trace("Tests successful!!");
	}
}
