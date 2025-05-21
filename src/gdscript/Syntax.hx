package gdscript;

import haxe.macro.Context;
import haxe.macro.Expr;

class Syntax {
	/**
		Assign this to a variable declaration to have the
		variable be generated without a value.

		This is helpful in rare circumstances.

		For example:
		```haxe
		@:const(preload = "res://texture.png")
		static final TEXTURE: godot.CompressedTexture2D = gdscript.Syntax.NoAssign;
		```

		Converts to:
		```gdscript
		const TEXTURE: CompressedTexture2D = preload("res://texture.png");
		```
	**/
	@:uncompilable
	public static var NoAssign: Dynamic;

	/**
		Generates an `is` expression in GDScript.

		For example:
		```haxe
		if(gdscript.Syntax.is(sprite, Sprite2D)) {
			cast(sprite, Sprite2D).centered = true;
		}
		```

		Converts to:
		```gdscript
		if sprite is Sprite2D:
			(sprite as Sprite2D).centered = true;
		```
	**/
	@:nativeFunctionCode("({arg0} is {arg1})")
	public static extern function is<T, U>(any: T, class_type: Class<U>): Bool;

	/**
		Generates a % node reference.

		For example:
		```haxe
		var a: godot.Sprite2D = gdscript.Syntax.percent(MySprite);
		```

		Converts to:
		```gdscript
		var a: Sprite2D = %MySprite;
		```
	**/
	public static macro function percent(identifier: Expr): Expr {
		final identifier = switch(identifier.expr) {
			case EConst(CString(s, _) | CIdent(s)): s;
			case _: {
				Context.error("Expected String or identifier expression", identifier.pos);
				return macro {};
			}
		}

		final identifier = "%" + identifier;
		return macro untyped __gdscript__($v{identifier});
	}

	/**
		Generates a $ node reference.

		For example:
		```haxe
		var a: godot.Label = gdscript.Syntax.dollar(MyLabel);
		var b: godot.Label = gdscript.Syntax.dollar("Path/To/OtherLabel"); // must use String for slashes
		```

		Converts to:
		```gdscript
		var a: Label = $MyLabel;
		var b: Label = $Path/To/OtherLabel;
		```
	**/
	public static macro function dollar(identifier: Expr): Expr {
		final identifier = switch(identifier.expr) {
			case EConst(CString(s, _) | CIdent(s)): s;
			case _: {
				Context.error("Expected String or identifier expression", identifier.pos);
				return macro {};
			}
		}

		final identifier = "$" + identifier;
		return macro untyped __gdscript__($v{identifier});
	}
}
