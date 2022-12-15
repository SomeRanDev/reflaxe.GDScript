class_name Log



static func formatOutput(v, infos):
	var str = String(v)
	
	if (infos == null):
		return str
	
	var pstr = infos.fileName + ":" + infos.lineNumber
	
	if (infos.customParams != null):
		var _g = 0
		var _g1 = infos.customParams
		while (_g < _g1.length):
			var v = _g1[_g]
			++_g
			str += ", " + String(v)
	
	return pstr + ": " + str

static func trace(v, infos):
	var str = Log.formatOutput(v, infos)
	
	print(str)