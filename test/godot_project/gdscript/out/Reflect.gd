class_name Reflect

func _init():
	pass

static func hasField(o, fieldName):
	return fieldName in o

static func field(o, fieldName):
	return o.get(fieldName)

static func setField(o, fieldName, value):
	if (o is Dictionary):
		o[fieldName] = value
	else:
		o.set(fieldName, value)

static func getProperty(o, fieldName):
	var tempResult

	if ("get_" + fieldName in o):
		tempResult = o.get("get_" + fieldName).call()
	else:
		tempResult = o.get(fieldName)

	return tempResult

static func setProperty(o, fieldName, value):
	if ("set_" + fieldName in o):
		o.get("set_" + fieldName).call(value)
	else:
		Reflect.setField(o, fieldName, value)

static func callMethod(o, _func, args):
	return _func.callv(args)

static func fields(o):
	var list = o.get_property_list.call()
	var result = []
	var _g = 0

	while (_g < list.size()):
		var l = list[_g]
		_g += 1
		result.push_back(l.get("name"))

	return result

static func isFunction(f):
	return f is Callable

static func compare(a, b):
	var tempResult

	if (a < b):
		tempResult = -1
	else:
		if (a > b):
			tempResult = 1
		else:
			tempResult = 0

	return tempResult

static func compareMethods(f1, f2):
	return f1 == f2

static func isObject(v):
	return v is Object

static func isEnumValue(v):
	return v is Dictionary

static func deleteField(o, fieldName):
	var result = fieldName in o

	if ((result)):
		Reflect.setField(o, fieldName, null)

	return result

static func copy(o):
	if (o == null):
		return null
	if (o is Dictionary):
		return o.duplicate()

	assert(false, "Only anonymous structures (Dictionaries) may be used with `Reflect.copy`.")

static func makeVarArgs(f):
	return func(args):
		var tempArray
		if true:
			var _g = []
			var _g1 = 0
			var _g2 = args
			while (_g1 < _g2.size()):
				var v = _g2[_g1]
				_g1 += 1
				_g.push_back(v)
			tempArray = _g
		return f.call(tempArray)

