package haxe;

class Log {
	public static function formatOutput(v: Dynamic, infos: PosInfos): String {
		var str = Std.string(v);
		if (infos == null)
			return str;
		var pstr = infos.fileName + ":" + infos.lineNumber;
		if (infos.customParams != null)
			for (v in infos.customParams)
				str += ", " + Std.string(v);
		return pstr + ": " + str;
	}

	public static dynamic function trace(v: Dynamic, ?infos: PosInfos):Void {
		var str = formatOutput(v, infos);
		untyped __gdscript__("print({0})", str);
	}
}
