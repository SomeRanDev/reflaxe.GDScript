class_name Log

func _init():
	pass

static func formatOutput(v, infos):
	var _str = str(v)

	if (infos == null):
		return _str

	var pstr = infos.get("fileName") + ":" + str(infos.get("lineNumber"))

	if (infos.get("customParams") != null):
		var _g = 0
		var _g1 = infos.get("customParams")
		while (_g < _g1.size()):
			var v2 = _g1[_g]
			_g += 1
			_str += ", " + str(v2)

	return pstr + ": " + _str

