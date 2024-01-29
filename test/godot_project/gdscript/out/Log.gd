class_name Log

static var trace = func(v, infos = null):
	var str: String = Log.formatOutput(v, infos)
	print(str)

func _init():
	pass

static func formatOutput(v, infos: Dictionary) -> String:
	var str: String = str(v)

	if (infos == null):
		return str

	var pstr: String = infos.get("fileName") + ":" + str(infos.get("lineNumber"))

	if (infos.get("customParams") != null):
		var _g: int = 0
		var _g1 = infos.get("customParams")
		while (_g < _g1.size()):
			var v2 = _g1[_g]
			_g += 1
			str += ", " + str(v2)

	return pstr + ": " + str

