package;

class Reflect {
	@:runtime public inline static function hasField(o: Dynamic, fieldName: String): Bool {
		return untyped __gdscript__("{} in {}", fieldName, o);
	}

	@:runtime public inline static function field(o: Dynamic, fieldName: String): Dynamic {
		return untyped __gdscript__("{}.get({})", o, fieldName);
	}

	public static function setField(o: Dynamic, fieldName: String, value: Dynamic): Void {
		return if(isEnumValue(o)) {
			untyped __gdscript__("{}[{}] = {}", o, fieldName, value);
		} else {
			untyped __gdscript__("{}.set({}, {})", o, fieldName, value);
		}
	}

	public static function getProperty(o: Dynamic, fieldName: String): Dynamic {
		return if(hasField(o, "get_" + fieldName)) {
			field(o, "get_" + fieldName)();
		} else {
			field(o, fieldName);
		}
	}

	public static function setProperty(o: Dynamic, fieldName: String, value: Dynamic): Void {
		return if(hasField(o, "set_" + fieldName)) {
			field(o, "set_" + fieldName)(value);
		} else {
			setField(o, fieldName, value);
		}
	}

	@:runtime public inline static function callMethod(o: Dynamic, func: haxe.Constraints.Function, args: Array<Dynamic>): Dynamic {
		return untyped __gdscript__("{}.callv({})", func, args);
	}

	public static function fields(o: Dynamic): Array<String> {
		return untyped {
			final list: Array<{ name: String }> = o.get_property_list();
			var result = [];
			for(l in list) {
				result.push(l.name);
			}
			result;
		}
	}

	@:runtime public inline static function isFunction(f: Dynamic): Bool {
		return untyped __gdscript__("{} is Callable", f);
	}

	public static function compare<T>(a: T, b: T): Int {
		return if(untyped __gdscript__("{} < {}", a, b)) {
			-1;
		} else if(untyped __gdscript__("{} > {}", a, b)) {
			1;
		} else {
			0;
		}
	}

	@:runtime public inline static function compareMethods(f1: Dynamic, f2: Dynamic): Bool {
		return f1 == f2;
	}

	@:runtime public inline static function isObject(v: Dynamic): Bool {
		return untyped __gdscript__("{} is Object", v);
	}

	@:runtime public inline static function isEnumValue(v: Dynamic): Bool {
		return untyped __gdscript__("{} is Dictionary", v);
	}

	public static function deleteField(o: Dynamic, fieldName: String): Bool {
		final result = hasField(o, fieldName);
		if(result) Reflect.setField(o, fieldName, null);
		return result;
	}

	public static function copy<T>(o: Null<T>): Null<T> {
		if(o == null) return null;
		if(isEnumValue(o)) {
			return untyped __gdscript__("{}.duplicate()", o);
		}
		throw "Only anonymous structures (Dictionaries) may be used with `Reflect.copy`.";
	}

	@:overload(function(f:Array<Dynamic>->Void):Dynamic {})
	public static function makeVarArgs(f: Array<Dynamic>->Dynamic): Dynamic {
		return function(...args: Dynamic) {
			return f(args);
		}
	}
}