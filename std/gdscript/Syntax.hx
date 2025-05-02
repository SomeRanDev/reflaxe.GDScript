package gdscript;

import haxe.macro.Context;
import haxe.macro.Expr;

class Syntax {
	@:nativeFunctionCode("({arg0} is {arg1})")
	public static extern function is<T, U>(any: T, class_type: Class<U>): Bool;

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
}
