package gdcompiler;

#if (macro || gdscript_runtime)

import reflaxe.ReflectCompiler;

class GDCompilerInit {
	public static function Start() {
		ReflectCompiler.AddCompiler(new GDCompiler(), {
			fileOutputExtension: ".gdscript",
			outputDirDefineName: "gdscript-output",
			fileOutputType: FilePerClass,
			ignoreTypes: ["haxe.iterators.ArrayIterator"],
			targetCodeInjectionName: "__gdscript__",
			smartDCE: true
		});

		gdcompiler.mods.BytesMod.apply();
	}
}

#end
