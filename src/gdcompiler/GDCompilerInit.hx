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
			convertUnopIncrement: true,
			smartDCE: true,
			allowMetaMetadata: true,
			autoNativeMetaFormat: "@{}",
			metadataTemplates: [
				ReflectCompiler.MetaTemplate(":tool", "", true, [], [Class], (e, p) -> "@tool"),

				// ReflectCompiler.MetaTemplate(":onready", "", true, [], [ClassField], (e, p) -> "@onready"),
				ReflectCompiler.MetaTemplate(":icon", "", true, [String], [ClassField], (e, p) -> "@icon(" + p[0] + ")"),
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
		return Sys.getEnv("HAXELIB_RUN_NAME").toLowerCase() == "reflaxe.gdscript";
	}

	static function reservedNames() {
		return gdKeywords().concat(gdUtilityFuncs());
	}

	static function gdKeywords(): Array<String> {
		return [
			"func", "assert"
		];
	}

	// the "utility_functions" from the Godot extension_api.json
	static function gdUtilityFuncs(): Array<String> {
		return [
			"sin","cos","tan","sinh","cosh","tanh","asin","acos","atan","atan2","sqrt","fmod",
			"fposmod","posmod","floor","floorf","floori","ceil","ceilf","ceili","round","roundf",
			"roundi","abs","absf","absi","sign","signf","signi","snapped","snappedf","snappedi",
			"pow","log","exp","is_nan","is_inf","is_equal_approx","is_zero_approx","is_finite",
			"ease","step_decimals","lerp","lerpf","cubic_interpolate","cubic_interpolate_angle",
			"cubic_interpolate_in_time","cubic_interpolate_angle_in_time","bezier_interpolate",
			"bezier_derivative","lerp_angle","inverse_lerp","remap","smoothstep","move_toward",
			"deg_to_rad","rad_to_deg","linear_to_db","db_to_linear","wrap","wrapi","wrapf",
			"max","maxi","maxf","min","mini","minf","clamp","clampi","clampf","nearest_po2",
			"pingpong","randomize","randi","randf","randi_range","randf_range","randfn","seed",
			"rand_from_seed","weakref","typeof","str","error_string","print","print_rich",
			"printerr","printt","prints","printraw","print_verbose","push_error","push_warning",
			"var_to_str","str_to_var","var_to_bytes","bytes_to_var","var_to_bytes_with_objects",
			"bytes_to_var_with_objects","hash","instance_from_id","is_instance_id_valid",
			"is_instance_valid","rid_allocate_id","rid_from_int64"
		];
	}
}

#end
