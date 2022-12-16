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
			reservedVarNames: gdUtilityFuncs(),
			targetCodeInjectionName: "__gdscript__",
			smartDCE: true
		});

		ExpressionModifier.mod(transformUnopIncDecfunction);
	}

	static function transformUnopIncDecfunction(e: Expr): Null<Expr> {
		switch(e.expr) {
			case EUnop(op, postFix, e): {
				switch(op) {
					case OpIncrement: {
						return if(postFix) {
							macro {
								$e += 1;
								$e - 1;
							}
						} else {
							macro {
								$e += 1;
								$e;
							}
						}
					}
					case OpDecrement: {
						return if(postFix) {
							macro {
								$e -= 1;
								$e + 1;
							}
						} else {
							macro {
								$e -= 1;
								$e;
							}
						}
					}
					case _:
				}
			}
			case _:
		}
		return null;
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
