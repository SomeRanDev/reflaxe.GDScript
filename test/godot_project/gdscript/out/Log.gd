@tool
class_name haxe_Log

static var trace = func(v, infos = null) -> void:
	var _str: String = haxe_Log.formatOutput(v, infos)
	print(_str)

func _init() -> void:
	pass

static func formatOutput(v, infos: Variant) -> String:
	var _str: String = str(v)

	if (infos == null):
		return _str

	var pstr: String = infos.get("fileName") + ":" + str(infos.get("lineNumber"))

	if (infos.get("customParams") != null):
		var _g: int = 0
		var _g1 = infos.get("customParams")
		while (_g < _g1.size()):
			var v2 = _g1[_g]
			_g += 1
			_str += ", " + str(v2)

	return pstr + ": " + _str

