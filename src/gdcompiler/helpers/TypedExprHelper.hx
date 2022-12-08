package gdcompiler.helpers;

#if (macro || gdscript_runtime)

import haxe.macro.Type;

class TypedExprHelper {
	public static function copy(e: TypedExpr): TypedExpr {
		return {
			expr: e.expr,
			pos: e.pos,
			t: e.t
		}
	}
}

#end
