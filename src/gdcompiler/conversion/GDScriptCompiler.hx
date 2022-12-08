// =======================================================
// * GDScriptCompiler
//
// This class converts a TypedExpr into GDScript code.
// =======================================================

package gdcompiler.conversion;

#if (macro || gdscript_runtime)

using StringTools;

using gdcompiler.helpers.OperatorHelper;
using gdcompiler.helpers.SyntaxHelper;

import haxe.macro.Context;
import haxe.macro.Expr;
import haxe.macro.Type;
import haxe.macro.MacroStringTools;

class GDScriptCompiler {
	public var haxeExpr: TypedExpr;

	public function new(expr: TypedExpr) {
		haxeExpr = expr;
	}

	// Helper function to convert TypedExpr to GDScript code.
	public static function haxeExprToGDScript(expr: TypedExpr): String {
		final conv = new GDScriptCompiler(expr);
		return conv.toGDScript();
	}

	// Returns the result of calling "ExprOptimizer.optimizeAndUnwrap"
	// and "generateGDScriptFromExpressions" from the "haxeExpr".
	public function optimizeAndUnwrap(): String {
		final exprs = ExprOptimizer.optimizeAndUnwrap(haxeExpr);
		return generateGDScriptFromExpressions(exprs);
	}

	// Convert a list of expressions to lines of GDScript code.
	// The lines of code are spaced out to make it feel like
	// it was human-written.
	function generateGDScriptFromExpressions(exprList: Array<TypedExpr>): String {
		var currentType = -1;
		final lines = [];
		for(e in exprList) {
			final newType = expressionType(e);
			if(currentType != newType) {
				if(currentType != -1) lines.push("");
				currentType = newType;
			}
			lines.push(toGDScript(e));
		}
		return lines.join("\n");
	}

	// Each expression is assigned a "type" (represented by int).
	// When generating GDScript, expressions of the same type are kept
	// close together, while expressions of different types are
	// separated by a new line.
	//
	// This helps make the GDScript output look human-written.
	function expressionType(expr: Null<TypedExpr>): Int {
		return switch(expr.expr) {
			case TConst(_) |
				TLocal(_) |
				TArray(_, _) |
				TVar(_, _) |
				TTypeExpr(_) |
				TEnumParameter(_, _, _) |
				TEnumIndex(_) |
				TIdent(_): 0;
			
			case TBinop(_, _, _) |
				TCall(_, _) |
				TUnop(_, _, _) |
				TCast(_, _) |
				TField(_, _): 1;
			
			case TObjectDecl(_): 2;
			case TArrayDecl(_): 3;
			case TNew(_, _, _): 4;
			case TFunction(_): 5;
			case TBlock(_): 6;
			case TFor(_, _, _): 7;
			case TIf(_, _, _): 8;
			case TWhile(_, _, _): 9;
			case TSwitch(_, _, _): 10;
			case TTry(_, _): 11;
			case TReturn (_): 12;
			case TBreak | TContinue: 13;
			case TThrow(_): 14;
			case TMeta(_, e): expressionType(e);
			case TParenthesis(e): expressionType(e);
		}
	}

	// The main function for compiling the TypedExpr to GDScript.
	// If no parameter is provided, the stored "haxeExpr" is used.
	public function toGDScript(expr: Null<TypedExpr> = null): String {
		if(expr == null) expr = haxeExpr;

		var result = "";
		switch(expr.expr) {
			case TConst(constant): {
				result = constantToGDScript(constant);
			}
			case TLocal(v): {
				result = v.name;
			}
			case TArray(e1, e2): {
				result = toGDScript(e1) + "[" + toGDScript(e2) + "]";
			}
			case TBinop(op, e1, e2): {
				result = binopToGDScript(op, e1, e2);
			}
			case TField(e, fa): {
				result = fieldAccessToGDScript(e, fa);
			}
			case TTypeExpr(m): {
				result = moduleNameToGDScript(m);
			}
			case TParenthesis(e): {
				result = "(" + toGDScript(e) + ")";
			}
			case TObjectDecl(fields): {
				result = "{\n";
				for(i in 0...fields.length) {
					final field = fields[i];
					result += "\t\"" + field.name + "\": " + toGDScript(field.expr) + (i == fields.length - 1 ? "," : "") + "\n"; 
				}
				result += "}";
			}
			case TArrayDecl(el): {
				result = "[" + el.map(e -> toGDScript(e)).join(", ") + "]";
			}
			case TCall(e, el): {
				result = toGDScript(e) + "(" + el.map(e -> toGDScript(e)).join(", ") + ")";
			}
			case TNew(classTypeRef, _, el): {
				final className = classTypeRef.get().name;
				result = className + ".new(" + el.map(e -> toGDScript(e)).join(", ") + ")";
			}
			case TUnop(op, postFix, e): {
				result = unopToGDScript(op, e, postFix);
			}
			case TFunction(tfunc): {
				result = "func(" + tfunc.args.map(a -> a.v.name + (a.value != null ? toGDScript(a.value) : "")) + "):\n";
				result += toIndentedScope(tfunc.expr);
			}
			case TVar(tvar, expr): {
				result = "var " + tvar.name;
				if(expr != null) {
					result += " = " + toGDScript(expr);
				}
			}
			case TBlock(el): {
				result = "if true:\n";

				if(el.length > 0) {
					result += el.map(e -> {
						var content = toGDScript(e);
						toGDScript(e).tab();
					}).join("\n");
				} else {
					result += "\tpass";
				}
			}
			case TFor(tvar, iterExpr, blockExpr): {
				result = "for " + tvar.name + " in " + toGDScript(iterExpr) + ":\n";
				result += toIndentedScope(blockExpr);
			}
			case TIf(econd, ifExpr, elseExpr): {
				result = "if " + toGDScript(econd) + ":\n";
				result += toIndentedScope(ifExpr);
				if(elseExpr != null) {
					result += "\n";
					result += "else:\n";
					result += toIndentedScope(elseExpr);
				}
			}
			case TWhile(econd, blockExpr, normalWhile): {
				final gdCond = toGDScript(econd);
				if(normalWhile) {
					result = "while " + gdCond + ":\n";
					result += toIndentedScope(blockExpr);
				} else {
					result = "while true:\n";
					result += toIndentedScope(blockExpr);
					result += "\tif " + gdCond + ":\n";
					result += "\t\tbreak";
				}
			}
			case TSwitch(e, cases, edef): {
				result = "match " + toGDScript(e) + ":";
				for(c in cases) {
					result += "\n";
					result += "\t" + c.values.map(v -> toGDScript(v)).join(", ") + ":\n";
					result += toIndentedScope(c.expr).tab();
				}
				if(edef != null) {
					result += "\n";
					result += "\t_:\n";
					result += toIndentedScope(edef).tab();
				}
			}
			case TTry(e, catches): {
				// TODO
			}
			case TReturn(maybeExpr): {
				if(maybeExpr != null) {
					result = "return " + toGDScript(maybeExpr);
				} else {
					result = "return";
				}
			}
			case TBreak: {
				result = "break";
			}
			case TContinue: {
				result = "continue";
			}
			case TThrow(expr): {
				result = "throw " + toGDScript(expr);
			}
			case TCast(expr, maybeModuleType): {
				result = toGDScript(expr);
				if(maybeModuleType != null) {
					result += " as " + moduleNameToGDScript(maybeModuleType);
				}
			}
			case TMeta(metadataEntry, expr): {
				result = toGDScript(expr);
			}
			case TEnumParameter(expr, enumField, index): {
				result = Std.string(index + 2);
			}
			case TEnumIndex(expr): {
				result = "[1]";
			}
			case _: {}
		}
		return result;
	}

	// Compiles the TypedExpr to GDScript and returns
	// an indented version of the code.
	function toIndentedScope(e: TypedExpr): String {
		return switch(e.expr) {
			case TBlock(el): {
				if(el.length > 0) {
					el.map(e -> toGDScript(e).tab()).join("\n");
				} else {
					"\tpass";
				}
			}
			case _: {
				toGDScript(e).tab();
			}
		}
	}

	function constantToGDScript(constant: TConstant): String {
		switch(constant) {
			case TInt(i): return Std.string(i);
			case TFloat(s): return s;
			case TString(s): return "\"" + s + "\"";
			case TBool(b): return b ? "true" : "false";
			case TNull: return "null";
			case TThis: return "self";
			case TSuper: return "super";
			case _: {}
		}
		return "";
	}

	function binopToGDScript(op: Binop, e1: TypedExpr, e2: TypedExpr): String {
		final gdExpr1 = toGDScript(e1);
		final gdExpr2 = toGDScript(e2);
		final operatorStr = OperatorHelper.binopToString(op);
		return gdExpr1 + " " + operatorStr + " " + gdExpr2;
	}

	function unopToGDScript(op: Unop, e: TypedExpr, isPostfix: Bool): String {
		final gdExpr = toGDScript(e);
		final operatorStr = OperatorHelper.unopToString(op);
		return isPostfix ? (gdExpr + operatorStr) : (operatorStr + gdExpr);
	}

	function fieldAccessToGDScript(e: TypedExpr, fa: FieldAccess): String {
		final gdExpr = toGDScript(e);
		final fieldName = switch(fa) {
			case FInstance(_, _, classFieldRef): classFieldRef.get().name;
			case FStatic(_, classFieldRef): classFieldRef.get().name;
			case FAnon(classFieldRef): classFieldRef.get().name;
			case FDynamic(s): s;
			case FClosure(_, classFieldRef): classFieldRef.get().name;
			case FEnum(_, enumField): enumField.name;
		}
		return gdExpr + "." + fieldName;
	}

	function moduleNameToGDScript(m: ModuleType): String {
		return switch(m) {
			case TClassDecl(classTypeRef): classTypeRef.get().name;
			case TEnumDecl(enumTypeRef): enumTypeRef.get().name;
			case TTypeDecl(defTypeRef): {
				final realType = defTypeRef.get().type;
				typeNameToGDScript(realType, defTypeRef.get().pos);
			}
			case TAbstract(abstractTypeRef): {
				final realType = abstractTypeRef.get().type;
				typeNameToGDScript(realType, abstractTypeRef.get().pos);
			}
		}
	}

	function typeNameToGDScript(t: Type, errorPos: Position): String {
		final ct = haxe.macro.TypeTools.toComplexType(t);
		final typeName = switch(ct) {
			case TPath(typePath): {
				// copy TypePath and ignore "params" since GDScript is typeless
				haxe.macro.ComplexTypeTools.toString(TPath({
					name: typePath.name,
					pack: typePath.pack,
					sub: typePath.sub,
					params: null
				}));
			}
			case _: null;
		}
		if(typeName == null) {
			Context.error("Incomplete Feature: Cannot convert this type to GDScript at the moment.", errorPos);
		}
		return typeName;
	}
}

#end
