package test;

class TestAll {
	public static function test() {
		TestSyntax.test();
		TestMath.test();
		TestStd.test();
		TestString.test();
		TestStaticVar.test();
		TestArray.test();
		TestEnum.test();
		TestMeta.test();
		TestSys.test();
		TestEReg.test();
		TestReflect.test();
		TestClass.test();

		trace("Tests successful!!");
	}
}
