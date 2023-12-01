package gdcompiler.subcompilers;

import gdcompiler.GDCompiler;

import reflaxe.helpers.Context;
import haxe.macro.Expr;
import haxe.macro.Type;

using reflaxe.helpers.ArrayHelper;
using reflaxe.helpers.BaseTypeHelper;
using reflaxe.helpers.ModuleTypeHelper;
using reflaxe.helpers.NameMetaHelper;
using reflaxe.helpers.TypeHelper;

@:access(gdcompiler.GDCompiler)
class TypeCompiler {
	var main: GDCompiler;

	public function new(main: GDCompiler) {
		this.main = main;
	}

	public function compileClassName(classType: ClassType): String {
		return classType.getNameOrNativeName();
	}

	public function compileModuleType(m: ModuleType): String {
		return switch(m) {
			case TClassDecl(clsRef): {
				compileClassName(clsRef.get());
			}
			case TEnumDecl(enmRef): {
				final e = enmRef.get();
				if(e.isReflaxeExtern()) {
					e.pack.joinAppend(".") + e.getNameOrNativeName();
				} else {
					"Dictionary";
				}
			}
			case _: m.getNameOrNative();
		}
	}

	public function compileType(t: Type, errorPos: Position): Null<String> {
		switch(t) {
			case TAbstract(absRef, params): {
				return if(params.length == 0) {
					switch(absRef.get().name) {
						case "Void": "void";
						case "Int": "int";
						case "Float":"float";
						case "Single": "float";
						case "Bool": "bool";
						case "Any" | "Dynamic": null;
						case _: null;
					}
				} else {
					null;
				}
			}

			case TDynamic(_): return null;
			case TAnonymous(_): return "Dictionary";
			case TFun(_, _): return null;
			case _ if(t.isTypeParameter()): return null;

			case TInst(clsRef, _): return compileModuleType(TClassDecl(clsRef));
			case TEnum(enmRef, _): return compileModuleType(TEnumDecl(enmRef));
			case TType(defRef, _): return compileType(defRef.get().type, errorPos);
			case _:
		}

		trace(t);

		// Old behavior
		// TODO: Phase this out...
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
			return Context.error("Incomplete Feature: Cannot convert this type to GDScript at the moment. " + Std.string(t), errorPos);
		}
		return typeName;
	}
}
