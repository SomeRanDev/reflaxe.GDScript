package gdcompiler;

#if (macro || gdscript_runtime)

import haxe.macro.Expr;

import reflaxe.ReflectCompiler;

import reflaxe.input.ExpressionModifier;

class GDCompilerInit {
	public static function Start() {
		ReflectCompiler.AddCompiler(new GDCompiler(), {
			fileOutputExtension: ".gd",
			outputDirDefineName: "gdscript-output",
			fileOutputType: FilePerClass,
			ignoreTypes: ["haxe.iterators.ArrayIterator"],
			targetCodeInjectionName: "__gdscript__",
			smartDCE: true
		});

		ExpressionModifier.mod(function(e: Expr) {
			switch(e.expr) {
				case EUnop(op, postFix, e): {
					switch(op) {
						case OpIncrement: {
							return if(postFix) {
								macro ($e += 1) - 1;
							} else {
								macro ($e += 1);
							}
						}
						case OpDecrement: {
							return if(postFix) {
								macro ($e -= 1) - 1;
							} else {
								macro ($e -= 1);
							}
						}
						case _:
					}
				}
				case _:
			}
			return null;
		});
	}
}

#end
