package gdcompiler;

#if (macro || gdscript_runtime)

import haxe.macro.Context;
import haxe.macro.Expr;
import haxe.macro.Type;

import reflaxe.BaseCompiler;
import reflaxe.helpers.OperatorHelper;

using reflaxe.helpers.BaseCompilerHelper;
using reflaxe.helpers.SyntaxHelper;
using reflaxe.helpers.ModuleTypeHelper;
using reflaxe.helpers.NameMetaHelper;
using reflaxe.helpers.TypedExprHelper;

class GDCompiler extends reflaxe.BaseCompiler {
	public function compileClassImpl(classType: ClassType, varFields: ClassFieldVars, funcFields: ClassFieldFuncs): Null<String> {
		final variables = [];
		final functions = [];

		for(v in varFields) {
			final field = v.field;
			final variableDeclaration = "var " + field.name;
			final gdScriptVal = if(field.expr() != null) {
				" = " + compileClassVarExpr(field.expr());
			} else {
				"";
			}
			variables.push(variableDeclaration + gdScriptVal);
		}

		for(f in funcFields) {
			final field = f.field;
			final tfunc = f.tfunc;
			final prefix = f.isStatic ? "static " : "";
			final funcDeclaration = prefix + "func " + field.name + "(" + tfunc.args.map(a -> a.v.name).join(", ") + "):\n";
			final gdScriptVal = if(tfunc.expr != null) {
				compileClassFuncExpr(tfunc.expr).tab();
			} else {
				"pass";
			}
			functions.push(funcDeclaration + gdScriptVal);
		}

		if(variables.length <= 0 && functions.length <= 0) {
			return null;
		}

		var header = "";

		if(classType.superClass != null) {
			header += "extends " + classType.superClass.t.get().name + "\n";
		}

		header += "class_name " + classType.name + "\n\n";

		return header + variables.join("\n\n") + "\n\n" + functions.join("\n\n");
	}
  
	 public function compileEnumImpl(enumType: EnumType, constructs: Map<String, haxe.macro.EnumField>): Null<String> {
		return null;
	}
  
	 public function compileExpressionImpl(expr: TypedExpr): Null<String> {
		var result = "";
		switch(expr.expr) {
			case TConst(constant): {
				result = constantToGDScript(constant);
			}
			case TLocal(v): {
				result = v.name;
			}
			case TArray(e1, e2): {
				result = compileExpression(e1) + "[" + compileExpression(e2) + "]";
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
				result = "(" + compileExpression(e) + ")";
			}
			case TObjectDecl(fields): {
				result = "{\n";
				for(i in 0...fields.length) {
					final field = fields[i];
					result += "\t\"" + field.name + "\": " + compileExpression(field.expr) + (i == fields.length - 1 ? "," : "") + "\n"; 
				}
				result += "}";
			}
			case TArrayDecl(el): {
				result = "[" + el.map(e -> compileExpression(e)).join(", ") + "]";
			}
			case TCall(e, el): {
				final nfc = this.compileNativeFunctionCodeMeta(e, el);
				result = if(nfc != null) {
					nfc;
				} else {
					compileExpression(e) + "(" + el.map(e -> compileExpression(e)).join(", ") + ")";
				}
			}
			case TNew(classTypeRef, _, el): {
				final className = classTypeRef.get().name;
				result = className + ".new(" + el.map(e -> compileExpression(e)).join(", ") + ")";
			}
			case TUnop(op, postFix, e): {
				result = unopToGDScript(op, e, postFix);
			}
			case TFunction(tfunc): {
				result = "func(" + tfunc.args.map(a -> a.v.name + (a.value != null ? compileExpression(a.value) : "")) + "):\n";
				result += toIndentedScope(tfunc.expr);
			}
			case TVar(tvar, expr): {
				result = "var " + tvar.name;
				if(expr != null) {
					result += " = " + compileExpression(expr);
				}
			}
			case TBlock(el): {
				result = "if true:\n";

				if(el.length > 0) {
					result += el.map(e -> {
						var content = compileExpression(e);
						compileExpression(e).tab();
					}).join("\n");
				} else {
					result += "\tpass";
				}
			}
			case TFor(tvar, iterExpr, blockExpr): {
				result = "for " + tvar.name + " in " + compileExpression(iterExpr) + ":\n";
				result += toIndentedScope(blockExpr);
			}
			case TIf(econd, ifExpr, elseExpr): {
				result = "if " + compileExpression(econd) + ":\n";
				result += toIndentedScope(ifExpr);
				if(elseExpr != null) {
					result += "\n";
					result += "else:\n";
					result += toIndentedScope(elseExpr);
				}
			}
			case TWhile(econd, blockExpr, normalWhile): {
				final gdCond = compileExpression(econd);
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
				result = "match " + compileExpression(e) + ":";
				for(c in cases) {
					result += "\n";
					result += "\t" + c.values.map(v -> compileExpression(v)).join(", ") + ":\n";
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
					result = "return " + compileExpression(maybeExpr);
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
				result = "throw " + compileExpression(expr);
			}
			case TCast(expr, maybeModuleType): {
				result = compileExpression(expr);
				if(maybeModuleType != null) {
					result += " as " + moduleNameToGDScript(maybeModuleType);
				}
			}
			case TMeta(metadataEntry, expr): {
				result = compileExpression(expr);
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

	function toIndentedScope(e: TypedExpr): String {
		return switch(e.expr) {
			case TBlock(el): {
				if(el.length > 0) {
					el.map(e -> compileExpression(e).tab()).join("\n");
				} else {
					"\tpass";
				}
			}
			case _: {
				compileExpression(e).tab();
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
		final gdExpr1 = compileExpression(e1);
		final gdExpr2 = compileExpression(e2);
		final operatorStr = OperatorHelper.binopToString(op);
		return gdExpr1 + " " + operatorStr + " " + gdExpr2;
	}

	function unopToGDScript(op: Unop, e: TypedExpr, isPostfix: Bool): String {
		final gdExpr = compileExpression(e);
		final operatorStr = OperatorHelper.unopToString(op);
		return isPostfix ? (gdExpr + operatorStr) : (operatorStr + gdExpr);
	}

	function fieldAccessToGDScript(e: TypedExpr, fa: FieldAccess): String {
		final nameMeta: NameAndMeta = switch(fa) {
			case FInstance(_, _, classFieldRef): classFieldRef.get();
			case FStatic(_, classFieldRef): classFieldRef.get();
			case FAnon(classFieldRef): classFieldRef.get();
			case FClosure(_, classFieldRef): classFieldRef.get();
			case FEnum(_, enumField): enumField;
			case FDynamic(s): { name: s, meta: null };
		}

		return if(nameMeta.hasMeta(":native")) {
			nameMeta.getNameOrNative();
		} else {
			final gdExpr = compileExpression(e);
			return gdExpr + "." + nameMeta.getNameOrNativeName();
		}
	}

	function moduleNameToGDScript(m: ModuleType): String {
		return m.getNameOrNative();
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
