package gdcompiler;

#if (macro || gdscript_runtime)

import haxe.macro.Compiler;
import haxe.macro.Expr;
import haxe.macro.Type;

import haxe.display.Display.MetadataTarget;

import reflaxe.ReflectCompiler;

import reflaxe.input.ExpressionModifier;

using reflaxe.helpers.ExprHelper;

class GDCompilerInit {
	public static function Start() {
		if(isRunScript()) {
			return;
		}

		// Add our compiler to Reflaxe
		ReflectCompiler.AddCompiler(new GDCompiler(), {
			fileOutputExtension: ".gd",
			outputDirDefineName: "gdscript-output",
			fileOutputType: FilePerClass,
			ignoreTypes: ["haxe.iterators.ArrayIterator"],
			reservedVarNames: reservedNames(),
			targetCodeInjectionName: "__gdscript__",
			wrapLambdaCaptureVarsInArray: true,
			processAvoidTemporaries: true,
			convertUnopIncrement: true,
			smartDCE: true,
			allowMetaMetadata: true,
			autoNativeMetaFormat: "@{}",
			metadataTemplates: [
				ReflectCompiler.MetaTemplate(":tool", "", true, [], [Class], (e, p) -> "@tool"),

				// ReflectCompiler.MetaTemplate(":onready", "", true, [], [ClassField], (e, p) -> "@onready"),
				ReflectCompiler.MetaTemplate(":export", "", true, [], [ClassField], (e, p) -> "@export"),

				ReflectCompiler.MetaTemplate(":exportEnum", "", true, null, [ClassField], (e, p) -> "@export_enum(" + p.join(", ") + ")"),
				ReflectCompiler.MetaTemplate(":exportFile", "", true, [Optional], [ClassField], (e, p) -> {
					"@export_file" + (p.length > 0 ? ("(" + p.join(", ") + ")") : "");
				}),
				ReflectCompiler.MetaTemplate(":exportDir", "", true, [], [ClassField], (e, p) -> "@export_dir"),
				ReflectCompiler.MetaTemplate(":exportGlobalFile", "", true, [Optional], [ClassField], (e, p) -> {
					"@export_global_file" + (p.length > 0 ? ("(" + p.join(", ") + ")") : "");
				}),

				ReflectCompiler.MetaTemplate(":exportGlobalDir", "", true, [], [ClassField], (e, p) -> "@export_global_dir"),
				ReflectCompiler.MetaTemplate(":exportMultiline", "", true, [], [ClassField], (e, p) -> "@export_multiline"),
				ReflectCompiler.MetaTemplate(":exportRange", "", true, [Number, Number, Optional, Optional, Optional], [ClassField], (e, p) -> "@export_range(" + p.join(", ") + ")"),
				
				ReflectCompiler.MetaTemplate(":exportExpEasing", "", true, [], [ClassField], (e, p) -> "@export_exp_easing"),
				ReflectCompiler.MetaTemplate(":exportColorNoAlpha", "", true, [], [ClassField], (e, p) -> "@export_color_no_alpha"),
				
				ReflectCompiler.MetaTemplate(":exportNodePath", "", true, null, [ClassField], (e, p) -> "@export_node_path(" + p.join(", ") + ")"),
				ReflectCompiler.MetaTemplate(":exportFlags", "", true, null, [ClassField], (e, p) -> "@export_flags(" + p.join(", ") + ")"),

				ReflectCompiler.MetaTemplate(":exportFlags2dPhysics", "", true, [], [ClassField], (e, p) -> "@export_flags_2d_physics"),
				ReflectCompiler.MetaTemplate(":exportFlags2dRender", "", true, [], [ClassField], (e, p) -> "@export_flags_2d_render"),
				ReflectCompiler.MetaTemplate(":exportFlags2dNavigation", "", true, [], [ClassField], (e, p) -> "@export_flags_2d_navigation"),
				ReflectCompiler.MetaTemplate(":exportFlags3dPhysics", "", true, [], [ClassField], (e, p) -> "@export_flags_3d_physics"),
				ReflectCompiler.MetaTemplate(":exportFlags3dRender", "", true, [], [ClassField], (e, p) -> "@export_flags_3d_render"),
				ReflectCompiler.MetaTemplate(":exportFlags3dNavigation", "", true, [], [ClassField], (e, p) -> "@export_flags_3d_navigation")
			]
		});
	}

	/**
		We don't want this running during our "Run.hx" script, so this checks if that is occuring.
	**/
	static function isRunScript() {
		return ["reflaxe.gdscript", "gdscript"].contains((Sys.getEnv("HAXELIB_RUN_NAME") ?? "").toLowerCase());
	}

	/**
		List of reserved words found here:
		https://docs.godotengine.org/en/stable/tutorials/scripting/gdscript/gdscript_basics.html

		Added "load" manually? Maybe should remove?
	**/
	static var _reservedNames = [
		"if", "elif", "else", "for", "while", "match", "break", "continue", "pass",
		"return", "class", "class_name", "extends", "is", "in", "as", "self", "signal",
		"func", "static", "const", "enum", "var", "breakpoint", "load", "preload",
		"await", "yield", "assert", "void", "PI", "TAU", "INF", "NAN",

		"void", "bool", "int", "float", 

		// Reserved for @:wrapper argument
		"_self"
	];
	static function reservedNames() {
		return _reservedNames;
	}
}

#end
