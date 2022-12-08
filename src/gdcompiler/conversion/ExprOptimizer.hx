package gdcompiler.conversion;

#if (macro || gdscript_runtime)

import haxe.macro.Type;

class ExprOptimizer {
	public static function optimizeAndUnwrap(expr: TypedExpr): Array<TypedExpr> {
		return unwrapBlock(optimizeBlocks(expr));
	}

	public static function unwrapBlock(expr: TypedExpr): Array<TypedExpr> {
		return switch(expr.expr) {
			case TBlock(exprList): exprList;
			case _: [expr];
		}
	}

	public static function optimizeBlocks(expr: TypedExpr): TypedExpr {
		return switch(expr.expr) {
			case TBlock(exprList): {
				if(exprList.length == 1) {
					return exprList[0];
				} else {
					for(i in 0...exprList.length) {
						exprList[i] = optimizeBlocks(exprList[i]);
					}
					return {
						expr: TBlock(exprList),
						pos: expr.pos,
						t: expr.t
					};
				}
			}
			case _: expr;
		}
	}
}

#end
