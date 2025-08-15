package test;

class TestPreload {
	@:const(preload = "res://TestImageTexture.tres") // @:const
	public static final INSTANCE = gdscript.Syntax.NoAssign;

	function func() {
		TestPreload.INSTANCE; 
	}
}

class TestMetadata {
	function func() {
		TestPreload.INSTANCE; 
	}
}
