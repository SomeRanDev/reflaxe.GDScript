package gdcompiler;

#if (macro || gdscript_runtime)

import haxe.macro.Expr;

import reflaxe.ReflectCompiler;

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
	}
}

#end
