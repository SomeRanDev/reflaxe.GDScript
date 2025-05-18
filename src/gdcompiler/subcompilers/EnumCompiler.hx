package gdcompiler.subcompilers;

import haxe.macro.Type;

import reflaxe.data.EnumOptionData;

using reflaxe.helpers.ArrayHelper;
using reflaxe.helpers.BaseTypeHelper;
using reflaxe.helpers.ClassFieldHelper;
using reflaxe.helpers.ClassTypeHelper;
using reflaxe.helpers.ExprHelper;
using reflaxe.helpers.ModuleTypeHelper;
using reflaxe.helpers.NameMetaHelper;
using reflaxe.helpers.NullableMetaAccessHelper;
using reflaxe.helpers.NullHelper;
using reflaxe.helpers.OperatorHelper;
using reflaxe.helpers.StringBufHelper;
using reflaxe.helpers.SyntaxHelper;
using reflaxe.helpers.TypedExprHelper;
using reflaxe.helpers.TypeHelper;

// ---

enum EnumCompileKind {
	GDScriptEnum;
	AsInt;
	AsDictionary;
}

// ---

@:access(gdcompiler.GDCompiler)
class EnumCompiler {
	var main: GDCompiler;

	public function new(main: GDCompiler) {
		this.main = main;
	}

	public function compile(enumType: EnumType, options:Array<EnumOptionData>, path) {
		if(getCompileKind(enumType) != GDScriptEnum) {
			return;
		}

		final name = main.typeCompiler.compileEnumName(enumType);

		final content = new StringBuf();
		content.addMulti("class_name ", name, " extends Object\n\n");
		content.addMulti("enum ", name, " {\n");
		for(option in options) {
			content.addMulti("\t", option.name, ",\n");
		}
		content.add("}\n");

		main.setExtraFile(path, content.toString());
	}

	public function getCompileKind(enumType: EnumType): EnumCompileKind {
		var storesData = false;

		for(_ => value in enumType.constructs) {
			final args = switch(value.type) {
				case TFun(args, ret): args;
				case _: [];
			}
			
			if(args.length > 0) {
				storesData = true;
				break;
			}
		}

		return storesData ? AsDictionary : GDScriptEnum;
	}

	public function compileExpressionFromIndex(enumType: EnumType, enumField: EnumField, exprArgsPassed: Null<Array<TypedExpr>>) {
		if(enumType.isReflaxeExtern()) {
			return enumType.getNameOrNative() + "." + enumField.name;
		}

		final providedArgs = exprArgsPassed != null && exprArgsPassed.length > 0;
		final kind = if(providedArgs) {
			AsDictionary;
		} else {
			getCompileKind(enumType);
		}

		return switch(kind) {
			case GDScriptEnum: {
				final name = main.typeCompiler.compileEnumName(enumType);
				name + "." + name + "." + enumField.name;
			}
			case AsInt: {
				Std.string(enumField.index);
			}
			case AsDictionary if(exprArgsPassed != null && providedArgs): { // Redundant null-check for null-safety
				final result = new StringBuf();
				final enumFieldArgs = switch(enumField.type) {
					case TFun(args, _): args;
					case _: [];
				}

				result.addMulti("{ \"_index\": ", Std.string(enumField.index), ", ");
				for(i in 0...exprArgsPassed.length) {
					if(enumFieldArgs[i] == null) {
						continue;
					}
					result.addMulti("\"", enumFieldArgs[i].name, "\": ", main.compileExpressionOrError(exprArgsPassed[i]));
					if(i < exprArgsPassed.length - 1) {
						result.add(", ");
					}
				}
				result.add(" }");
				result.toString();
			}
			case AsDictionary: {
				"{ \"_index\": " + enumField.index + " }";
			}
		}
	}
}