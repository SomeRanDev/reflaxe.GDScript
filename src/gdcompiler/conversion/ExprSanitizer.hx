// =======================================================
// * ExprSanitizer
//
// Converts all of Haxe's expressions that do not have a correlating
// GDScript equivalent into a subset that's easier to transpile.
//
// The sanitation does not handle the "everything is an expression"
// capabilities of Haxe. That is handled in a following step.
// As a result, the sanitized code is capable of generating
// blocks with sub-expressions that return a value.
// =======================================================

package gdcompiler.conversion;

#if (macro || gdscript_runtime)

using gdcompiler.helpers.TypedExprHelper;

import haxe.macro.TypedExpr;

class ExprSanitizer {
	public var haxeExpr: TypedExpr;

	public function new(expr: TypedExpr) {
		haxeExpr = expr.copy();
	}

	public function sanitizedExpr(inputExpr: Null<TypedExpr> = null): TypedExpr {
		var result: TypedExpr = inputExpr != null ? inputExpr.copy() : haxeExpr;
		switch(haxeExpr.expr) {
			/*case TConst(constant): {
				result = sanitizedConstant(constant);
			}*/
			case _: {}
		}
		return haxe.macro.ExprTools.map(result, sanitizedExpr);
	}

	public function sanitizedConstant(): Null<Expr> {
		return switch(constant) {
			/*case CString(s, kind): {
				switch(kind) {
					case SingleQuotes: {
						MacroStringTools.formatString(s, Context.currentPos());
					}
					case _: {
						null;
					}
				}
			}
			case CRegexp(regexString, options): {
				return macro {
					var regex = new RegEx();
					regex.compile($i{regexString});
					regex;
				};
			}*/
			case _: null;
		}
	}
}

#end
