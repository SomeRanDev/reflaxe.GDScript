class_name Reflect

func _init() -> void:
	pass

static func hasField(o, fieldName: String) -> bool:
	return fieldName in o

static func field(o, fieldName: String):
	return o.get(fieldName)

static func setField(o, fieldName: String, value) -> void:
	if ((o as Variant) is Dictionary):
		o[fieldName] = value
	else:
		o.set(fieldName, value)

static func getProperty(o, fieldName: String):
	var tempResult

	if ("get_" + fieldName in o):
		tempResult = o.get("get_" + fieldName).call()
	else:
		tempResult = o.get(fieldName)

	return tempResult

static func setProperty(o, fieldName: String, value) -> void:
	if ("set_" + fieldName in o):
		o.get("set_" + fieldName).call(value)
	else:
		Reflect.setField(o, fieldName, value)

static func callMethod(o, _func, args: Array[Variant]):
	return _func.callv(args)

static func fields(o) -> Array[String]:
	var list: Array[Variant] = o.get_property_list()
	var result: Array[String] = ([] as Array[String])
	var _g: int = 0

	while (_g < list.size()):
		var l: Variant = list[_g]
		_g += 1
		result.push_back(l.get("name"))

	return result

static func isFunction(f) -> bool:
	return (f as Variant) is Callable

static func compare(a, b) -> int:
	var tempResult

	if (a < b):
		tempResult = -1
	else:
		if (a > b):
			tempResult = 1
		else:
			tempResult = 0

	return tempResult

static func compareMethods(f1, f2) -> bool:
	return f1 == f2

static func isObject(v) -> bool:
	return (v as Variant) is Object

static func isEnumValue(v) -> bool:
	return (v as Variant) is Dictionary

static func deleteField(o, fieldName: String) -> bool:
	var result: bool = fieldName in o

	if (result):
		Reflect.setField(o, fieldName, null)

	return result

static func copy(o):
	if (o == null):
		return null
	if ((o as Variant) is Dictionary):
		return o.duplicate()

	assert(false, str("Only anonymous structures (Dictionaries) may be used with `Reflect.copy`."))

static func makeVarArgs(f):
	return func(args: Array[Variant]):
		var tempArray
		if true:
			var _g: Array[Variant] = ([] as Array[Variant])
			var _g1: int = 0
			var _g2: Array[Variant] = args
			while (_g1 < _g2.size()):
				var v = _g2[_g1]
				_g1 += 1
				_g.push_back(v)
			tempArray = _g
		return f.call(tempArray)
