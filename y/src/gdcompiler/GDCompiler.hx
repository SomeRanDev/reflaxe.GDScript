package gdcompiler;

#if (macro || gdscript_runtime)

//import haxe.macro.Context;
import reflaxe.helpers.Context;
import haxe.macro.Expr;
import haxe.macro.Type;

import haxe.display.Display.MetadataTarget;

import reflaxe.data.ClassVarData;
import reflaxe.data.ClassFuncData;
import reflaxe.data.EnumOptionData;

import reflaxe.DirectToStringCompiler;
import reflaxe.compiler.EverythingIsExprSanitizer;
import reflaxe.helpers.OperatorHelper;

using reflaxe.helpers.SyntaxHelper;
using reflaxe.helpers.ModuleTypeHelper;
using reflaxe.helpers.NameMetaHelper;
using reflaxe.helpers.NullableMetaAccessHelper;
using reflaxe.helpers.NullHelper;
using reflaxe.helpers.OperatorHelper;
using reflaxe.helpers.TypedExprHelper;
using reflaxe.helpers.TypeHelper;

class GDCompiler extends reflaxe.DirectToStringCompiler {
	public override function onCompileStart() {
		setExtraFile("HxStaticVars.gd", "extends Node\n\n");
	}

	function isGodotNode(t: ClassType) {
		return if(t.isExtern && t.pack.length == 1 && t.pack[0] == "godot" && t.name == "Node") {
			true;
		} else if(t.superClass != null) {
			isGodotNode(t.superClass.t.get());
		} else {
			false;
		}
	}

	function compileClassName(classType: ClassType): String {
		//if(classType.has)
		return classType.getNameOrNative();
	}

	public function compileClassImpl(classType: ClassType, varFields: Array<ClassVarData>, funcFields: Array<ClassFuncData>): Null<String> {
		final variables = [];
		final functions = [];
		final staticVars = [];
		final className = classType.name;

		var header = "";

		final clsMeta = compileMetadata(classType.meta, MetadataTarget.Class);
		if(clsMeta != null) {
			header += clsMeta;
		}

		if(classType.superClass != null) {
			header += "extends " + compileClassName(classType.superClass.t.get()) + "\n";
		}

		header += "class_name " + compileClassName(classType) + "\n\n";

		// instance vars
		for(v in varFields) {
			final field = v.field;
			final varName = compileVarName(field.name, null, field);

			final e = field.expr();
			final gdScriptVal = if(e != null) {
				compileClassVarExpr(e);
			} else {
				"";
			}
			if(v.isStatic) {
				staticVars.push({ name: varName, expr: gdScriptVal });
			} else {
				final meta = compileMetadata(field.meta, MetadataTarget.ClassField);

				//:onready
				final meta = if(field.meta.has(":onready") && isGodotNode(classType)) {
					"@onready " + meta;
				} else {
					meta;
				}

				final decl = meta + "var " + varName + (gdScriptVal.length == 0 ? "" : (" = " + gdScriptVal));
				variables.push(decl);
			}
		}

		// class functions
		for(f in funcFields) {
			final field = f.field;
			final tfunc = f.tfunc;
			final name = field.name == "new" ? "_init" : compileVarName(field.name);
			final meta = compileMetadata(field.meta, MetadataTarget.ClassField) ?? "";

			if(f.kind == MethDynamic) {
				final e = field.expr();
				final callable = e == null ? "func():\n\tpass" : compileClassVarExpr(e);
				if(f.isStatic) {
					staticVars.push({
						name: name,
						expr: callable
					});
				} else {
					final decl = meta + "var " + name + " = " + callable;
					variables.push(decl);
				}
			} else {
				final prefix = f.isStatic ? "static " : "";
				final funcDeclaration = meta + prefix + "func " + name + "(" + (tfunc?.args ?? []).map(compileFunctionArgument).join(", ") + "):\n";
				var gdScriptVal = if(f.expr != null) {
					final result = compileClassFuncExpr(f.expr).tab();
					if(StringTools.trim(result).length == 0) {
						"\tpass";
					} else {
						result;
					}
				} else {
					"\tpass";
				}
				
				functions.push(funcDeclaration + gdScriptVal);
			}
		}

		// static vars
		if(staticVars.length > 0) {
			var declaration = "var _" + className + ": Dictionary = {\n";

			final fields = [];
			for(v in staticVars) {
				fields.push("\t\"" + v.name + "\": " + (v.expr != null ? v.expr : "null"));
			}

			declaration += fields.join(",\n") + "\n";
			declaration += "}\n\n";

			appendToExtraFile("HxStaticVars.gd", declaration);
		}

		// if there are no instance variables or functions,
		// we don't need to generate a class
		if(variables.length <= 0 && functions.length <= 0) {
			return null;
		}

		// TODO - Try this again after Godot beta??
		// Possible bug with GDScript 2.0 beta at the moment, but static
		// functions don't work unless there's a constructor defined.
		// So a blank GDScript constructor is created if one does not exist.
		if(classType.constructor == null) {
			functions.insert(0, "func _init():\n\tpass");
		}

		return {
			var result = header;

			if(variables.length > 0) {
				result += variables.join("\n\n") + "\n\n";
			}

			if(functions.length > 0) {
				result += functions.join("\n\n") + "\n\n";
			}

			result;
		}
	}

	function compileFunctionArgument(arg: { v: TVar, value: Null<TypedExpr> }) {
		var result = compileVarName(arg.v.name);
		if(arg.value != null) {
			result += " = " + compileExpression(arg.value);
		}
		return result;
	}

	function getNativeMetaString(metaAccess: Null<MetaAccess>) {
		var result = "";
		final nativeMeta = metaAccess.extractNativeMeta();
		if(nativeMeta != null) {
			for(m in nativeMeta) {
				result += "@" + m + "\n";
			}
		}
		return result;
	}

	public function compileEnumImpl(enumType: EnumType, options:Array<EnumOptionData>): Null<String> {
		return null;
	}
  
	public function compileExpressionImpl(expr: TypedExpr, isTopLevel: Bool): Null<String> {
		var result = "";
		switch(expr.expr) {
			case TConst(constant): {
				result = constantToGDScript(constant);
			}
			case TLocal(v): {
				result = compileVarName(v.name, expr);
				if(v.meta.maybeHas(":arrayWrap")) {
					result = result + "[0]";	
				}
			}
			case TIdent(s): {		
				result = compileVarName(s, expr);
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
				final gdScript = compileExpressionOrError(e);
				final expr = if(!EverythingIsExprSanitizer.isBlocklikeExpr(e)) {
					"(" + gdScript + ")";
				} else {
					gdScript;
				}
				result = expr;
			}
			case TObjectDecl(fields): {
				result = "{\n";
				for(i in 0...fields.length) {
					final field = fields[i];
					result += "\t\"" + field.name + "\": " + compileExpression(field.expr) + (i < fields.length - 1 ? "," : "") + "\n"; 
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
					final code = switch(e.expr) {
						case TField(_, fa): {
							switch(fa) {
								case FEnum(_, ef): {
									final enumCall = compileEnumFieldCall(e, el);
									if(enumCall != null) enumCall;
									else null;
								}
								case FStatic(classTypeRef, _.get() => cf) if(cf.meta.maybeHas(":constructor")): {
									newToGDScript(classTypeRef, expr, el);
								}
								case _: null;
							}
						}
						case _: null;
					}

					if(code != null) {
						code;
					} else {
						final callOp = if(isCallableVar(e)) {
							".call(";
						} else {
							"(";
						}
						compileExpression(e) + callOp + el.map(e -> compileExpressionOrError(e)).join(", ") + ")";
					}
				}
			}
			case TNew(classTypeRef, _, el): {
				result = newToGDScript(classTypeRef, expr, el);
			}
			case TUnop(op, postFix, e): {
				result = unopToGDScript(op, e, postFix);
			}
			case TFunction(tfunc): {
				result = "func(" + tfunc.args.map(compileFunctionArgument).join(", ") + "):\n";
				result += toIndentedScope(tfunc.expr);
			}
			case TVar(tvar, maybeExpr): {
				result = "var " + compileVarName(tvar.name, expr);
				if(maybeExpr != null) {
					final e = compileExpression(maybeExpr);
					if(tvar.meta.maybeHas(":arrayWrap")) {
						result += " = [" + e + "]";	
					} else {
						result += " = " + e;
					}
				}
			}
			case TBlock(el): {
				result = "if true:\n";

				if(el.length > 0) {
					result += el
						.map(e -> compileExpression(e))
						.filter(e -> e != null)
						.map(e -> e.trustMe().tab())
						.join("\n");
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
				result = compileExpressionOrError(e);
				final msg = "GDScript does not support try-catch. The expressions contained in the try block will be compiled, and the catches will be ignored.";
				Context.warning(msg, expr.pos);
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
				result = "assert(false, " + compileExpression(expr) + ")";
			}
			case TCast(expr, maybeModuleType): {
				result = compileExpressionOrError(expr);
				if(maybeModuleType != null) {
					result = "(" + result + " as " + moduleNameToGDScript(maybeModuleType) + ")";
				}
			}
			case TMeta(metadataEntry, expr): {
				result = compileExpressionOrError(expr);
			}
			case TEnumParameter(expr, enumField, index): {
				result = compileExpressionOrError(expr);
				switch(enumField.type) {
					case TFun(args, _): {
						if(index < args.length) {
							result += "." + args[index].name;
						}
					}
					case _:
				}
			}
			case TEnumIndex(expr): {
				result = compileExpression(expr) + "._index";
			}
		}
		return result;
	}

	function toIndentedScope(e: TypedExpr): String {
		return switch(e.expr) {
			case TBlock(el): {
				if(el.length > 0) {
					el
						.map(e -> compileExpression(e))
						.filter(e -> e != null)
						.map(e -> e.trustMe().tab())
						.join("\n");
				} else {
					"\tpass";
				}
			}
			case _: {
				final gdscript = compileExpression(e) ?? "pass";
				gdscript.tab();
			}
		}
	}

	function constantToGDScript(constant: TConstant): String {
		switch(constant) {
			case TInt(i): return Std.string(i);
			case TFloat(s): return s;
			case TString(s): return "\"" + StringTools.replace(StringTools.replace(s, "\\", "\\\\"), "\"", "\\\"") + "\"";
			case TBool(b): return b ? "true" : "false";
			case TNull: return "null";
			case TThis: return "self";
			case TSuper: return "super";
			case _: {}
		}
		return "";
	}

	function binopToGDScript(op: Binop, e1: TypedExpr, e2: TypedExpr): String {
		var gdExpr1 = compileExpression(e1);
		var gdExpr2 = compileExpression(e2);
		final operatorStr = OperatorHelper.binopToString(op);

		// Wrap primitives with str(...) when added with String
		if(op.isAddition()) {
			if(checkForPrimitiveStringAddition(e1, e2)) gdExpr2 = "str(" + gdExpr2 + ")";
			if(checkForPrimitiveStringAddition(e2, e1)) gdExpr1 = "str(" + gdExpr1 + ")";
		}

		return gdExpr1 + " " + operatorStr + " " + gdExpr2;
	}

	inline function checkForPrimitiveStringAddition(strExpr: TypedExpr, primExpr: TypedExpr) {
		return strExpr.t.isString() && primExpr.t.isPrimitive();
	}

	function newToGDScript(classTypeRef: Ref<ClassType>, originalExpr: TypedExpr, el: Array<TypedExpr>) {
		final nfc = this.compileNativeFunctionCodeMeta(originalExpr, el);
		return if(nfc != null) {
			nfc;
		} else {
			final meta = originalExpr.getDeclarationMeta()?.meta;
			final native = meta == null ? "" : ({ name: "", meta: meta }.getNameOrNative());
			final args = el.map(e -> compileExpression(e)).join(", ");
			if(native.length > 0) {
				native + "(" + args + ")";
			} else {
				final className = compileClassName(classTypeRef.get());
				className + ".new(" + args + ")";
			}
		}
	}

	function unopToGDScript(op: Unop, e: TypedExpr, isPostfix: Bool): String {
		final gdExpr = compileExpressionOrError(e);

		// OpIncrement and OpDecrement not supported in GDScript
		switch(op) {
			case OpIncrement: {
				return gdExpr + " += 1";
			}
			case OpDecrement: {
				return gdExpr + " -= 1";
			}
			case _:
		}

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
			final name = compileVarName(nameMeta.getNameOrNativeName());

			// Check if this is a static variable,
			// and if so use singleton.
			switch(fa) {
				case FStatic(clsRef, cfRef): {
					final cf = cfRef.get();
					final className = compileClassName(clsRef.get());
					switch(cf.kind) {
						case FVar(read, write): {
							return "HxStaticVars._" + className + "." + name;
						}
						case FMethod(kind): {
							if(kind == MethDynamic) {
								return "HxStaticVars._" + className + "." + name;
							}
						}
						case _:
					}
				}
				case FEnum(_, enumField): {
					return "{ \"_index\": " + enumField.index + " }";
				}
				case _:
			}

			final gdExpr = compileExpression(e);

			// Check if we're accessing an anonymous type.
			// If so, it's a Dictionary in GDScript and .get should be used.
			switch(fa) {
				case FAnon(classFieldRef): {
					return gdExpr + ".get(\"" + classFieldRef.get().name + "\")";
				}
				case _:
			}

			return gdExpr + "." + name;
		}
	}

	function moduleNameToGDScript(m: ModuleType): String {
		switch(m) {
			case TClassDecl(clsRef): compileClassName(clsRef.get());
			case _:
		}
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
			return Context.error("Incomplete Feature: Cannot convert this type to GDScript at the moment.", errorPos);
		}
		return typeName;
	}

	// In GDScript, a Callable is called differently from a function.
	// To help decern whether this is a variable containing a Callable,
	// or this is a normal function/method, this function is used.
	function isCallableVar(e: TypedExpr) {
		return switch(e.expr) {
			case TField(_, fa): {
				switch(fa) {
					case FInstance(_, _, clsFieldRef) |
						FStatic(_, clsFieldRef) |
						FClosure(_, clsFieldRef): {
						final clsField = clsFieldRef.get();
						switch(clsField.kind) {
							case FMethod(methKind): {
								methKind == MethDynamic;
							}
							case _: true;
						}
					}
					case _: true;
				}
			}
			case TConst(c): c != TSuper;
			case TParenthesis(e2) | TMeta(_, e2): isCallableVar(e2);
			case _: true;
		}
	}

	// This is called for called expressions.
	// If the typed expression is an enum field, transpile as a
	// Dictionary with the enum data.
	function compileEnumFieldCall(e: TypedExpr, el: Array<TypedExpr>): Null<String> {
		final ef = switch(e.expr) {
			case TField(_, fa): {
				switch(fa) {
					case FEnum(_, ef): ef;
					case _: null;
				}
			}
			case _: null;
		}

		return if(ef != null) {
			var result = "";
			switch(ef.type) {
				case TFun(args, _): {
					result = "{ \"_index\": " + ef.index + ", ";
					final fields = [];
					for(i in 0...el.length) {
						if(args[i] != null) {
							fields.push("\"" + args[i].name + "\": " + compileExpression(el[i]));
						}
					}
					result += fields.join(", ") + " }";
				}
				case _:
			}
			result;
		} else {
			null;
		}
	}
}

#end
