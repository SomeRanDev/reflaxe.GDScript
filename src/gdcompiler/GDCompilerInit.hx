package gdcompiler;

#if (macro || gdscript_runtime)

import haxe.macro.Compiler;
import haxe.macro.Expr;
import haxe.macro.Type;
import haxe.display.Display.MetadataTarget;

import reflaxe.ReflectCompiler;
import reflaxe.input.ExpressionModifier;
import reflaxe.preprocessors.ExpressionPreprocessor;

using reflaxe.helpers.ExprHelper;

class GDCompilerInit {
	public static function Start() {
		if(isRunScript()) {
			return;
		}

		// Add our compiler to Reflaxe
		ReflectCompiler.AddCompiler(new GDCompiler(), {
			expressionPreprocessors: [
				SanitizeEverythingIsExpression({
					convertIncrementAndDecrementOperators: true
				}),
				RemoveTemporaryVariables(OnlyAvoidTemporaryFieldAccess),
				PreventRepeatVariables({}),
				WrapLambdaCaptureVariablesInArray({
					wrapMetadata: [":copyType"]
				}),
				RemoveSingleExpressionBlocks,
				RemoveConstantBoolIfs,
				RemoveUnnecessaryBlocks,
				RemoveReassignedVariableDeclarations,
				RemoveLocalVariableAliases,
				MarkUnusedVariables,
			],
			fileOutputExtension: ".gd",
			outputDirDefineName: "gdscript-output",
			fileOutputType: FilePerClass,
			ignoreTypes: [],
			reservedVarNames: reservedNames(),
			targetCodeInjectionName: "__gdscript__",
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
				ReflectCompiler.MetaTemplate(":exportToolButton", "", true, [String, String], [ClassField], (e, p) -> {
					"@export_tool_button" + (p.length > 0 ? ("(" + p.join(", ") + ")") : "");
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
	**/
	static var _reservedNames = [
		// keywords
		"if", "elif", "else", "for", "while", "match", "break", "continue", "pass",
		"return", "class", "class_name", "extends", "is", "in", "as", "self", "signal",
		"func", "static", "const", "enum", "var", "breakpoint", "preload",
		"await", "yield", "assert", "void", "PI", "TAU", "INF", "NAN",

		// types
		"void", "bool", "int", "float",

		// utility_functions
		"sin", "cos", "tan", "sinh", "cosh", "tanh", "asin", "acos", "atan", "atan2",
		"asinh", "acosh", "atanh", "sqrt", "fmod", "fposmod", "posmod", "floor", "floorf",
		"floori", "ceil", "ceilf", "ceili", "round", "roundf", "roundi", "abs", "absf",
		"absi", "sign", "signf", "signi", "snapped", "snappedf", "snappedi", "pow", "log",
		"exp", "is_nan", "is_inf", "is_equal_approx", "is_zero_approx", "is_finite", "ease",
		"step_decimals", "lerp", "lerpf", "cubic_interpolate", "cubic_interpolate_angle",
		"cubic_interpolate_in_time", "cubic_interpolate_angle_in_time", "bezier_interpolate",
		"bezier_derivative", "angle_difference", "lerp_angle", "inverse_lerp", "remap", "smoothstep",
		"move_toward", "rotate_toward", "deg_to_rad", "rad_to_deg", "linear_to_db", "db_to_linear",
		"wrap", "wrapi", "wrapf", "max", "maxi", "maxf", "min", "mini", "minf", "clamp", "clampi",
		"clampf", "nearest_po2", "pingpong", "randomize", "randi", "randf", "randi_range", "randf_range",
		"randfn", "seed", "rand_from_seed", "weakref", "typeof", "type_convert", "str", "error_string",
		"type_string", "print", "print_rich", "printerr", "printt", "prints", "printraw", "print_verbose",
		"push_error", "push_warning", "var_to_str", "str_to_var", "var_to_bytes", "bytes_to_var",
		"var_to_bytes_with_objects", "bytes_to_var_with_objects", "hash", "instance_from_id", "is_instance_id_valid",
		"is_instance_valid", "rid_allocate_id", "rid_from_int64", "is_same",

		// Object fields
		// These are on ALL objects, so better to just be safe than sorry...
		"_get", "_get_property_list", "_init", "_iter_get", "_iter_init", "_iter_next", "_notification",
		"_property_can_revert", "_property_get_revert", "_set", "_to_string", "_validate_property",
		"get_class", "is_class", "set", "get", "set_indexed", "get_indexed", "get_property_list",
		"get_method_list", "property_can_revert", "property_get_revert", "notification", "to_string",
		"get_instance_id", "set_script", "get_script", "set_meta", "remove_meta", "get_meta", "has_meta",
		"get_meta_list", "add_user_signal", "has_user_signal", "remove_user_signal", "emit_signal", "call",
		"call_deferred", "set_deferred", "callv", "has_method", "get_method_argument_count", "has_signal",
		"get_signal_list", "get_signal_connection_list", "get_incoming_connections", "connect", "disconnect",
		"is_connected", "has_connections", "set_block_signals", "is_blocking_signals", "notify_property_list_changed",
		"set_message_translation", "can_translate_messages", "tr", "tr_n", "get_translation_domain", "set_translation_domain",
		"is_queued_for_deletion", "cancel_free",

		// Reserved for @:wrapper argument
		"_self"
	];
	static function reservedNames() {
		return _reservedNames;
	}
}

#end
