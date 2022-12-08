package gdcompiler;

#if (macro || gdscript_runtime)

import haxe.macro.Context;
import haxe.macro.Type;

using gdcompiler.helpers.SyntaxHelper;

import gdcompiler.conversion.GDScriptCompiler;
import gdcompiler.conversion.EverythingIsExprConversion;



class GDCompiler {
	static var moduleTypes: Array<ModuleType>;

	public static function Start() {
		Context.onAfterTyping(onAfterTyping);
		Context.onAfterGenerate(onAfterGenerate);
	}

	public static function onAfterTyping(mtypes: Array<ModuleType>) {
		moduleTypes = mtypes;
	}

	public static function onAfterGenerate() {
		// convert module members to gdscript
		for(mt in moduleTypes) {
			switch(mt) {
				case TClassDecl(clsTypeRef): {
					if(clsTypeRef.get().name == "Test") {
						transpileClass(clsTypeRef.get());
					}
				}
				case _: {}
			}
		}
	}

	static function toGDScript(expr: TypedExpr): String {
		final ec = new GDScriptCompiler(expr);
		return ec.optimizeAndUnwrap();
	}

	static function transpileClass(cls: ClassType) {
		final fieldList = cls.fields.get();
		final variables = [];
		final functions = [];

		for(field in fieldList) {
			if(field.isExtern) {
				continue;
			}

			switch(field.kind) {
				case FVar(readVarAccess, writeVarAccess): {
					final shouldGenerate = switch([readVarAccess, writeVarAccess]) {
						case [AccNormal | AccNo, AccNormal | AccNo]: true;
						case _: false;
					}
					if(shouldGenerate) {
						final variableDeclaration = "var " + field.name;
						final gdScriptVal = if(field.expr() != null) {
							" = " + toGDScript(field.expr());
						} else {
							"";
						}
						variables.push(variableDeclaration + gdScriptVal);
					}
				}
				case FMethod(methodKind): {
					var foundFunction = false;
					if(field.expr() != null) {
						switch(field.expr().expr) {
							case TFunction(tfunc): {
								functions.push(transpileClassFunction(field, tfunc));
								foundFunction = true;
							}
							case _: {}
						}
					}
					if(!foundFunction) {
						Context.error("Function information not found.", field.pos);
					}
				}
			}
		}
		
		final gdscriptContent = variables.join("\n\n") + "\n\n" + functions.join("\n\n");
		saveGDScriptFile(cls.name, gdscriptContent);
	}

	static function saveGDScriptFile(filename: String, content: String) {
		sys.io.File.saveContent(filename + ".gdscript", content);
	}

	static function transpileClassFunction(classField: ClassField,  tfunc: TFunc): String {
		final eiec = new EverythingIsExprConversion(tfunc.expr, null);
		final convertedExpr = eiec.convertedExpr();
		final gdScript = toGDScript(convertedExpr);
		final funcHeader = "func " + classField.name + "(" + tfunc.args.map(a -> a.v.name).join(", ") + "):\n";
		return funcHeader + gdScript.tab();
	}
}

#end
