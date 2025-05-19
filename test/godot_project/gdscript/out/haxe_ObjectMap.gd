class_name ObjectMap

var m: Dictionary[Variant, Variant]

func _init() -> void:
	self.m = {}

func __set(key, value) -> void:
	self.m.set(key, value)

func __get(key):
	var tempResult

	if (self.m.has(key)):
		tempResult = self.m.get(key)
	else:
		tempResult = null

	return tempResult

func exists(key) -> bool:
	return self.m.has(key)

func remove(key) -> bool:
	return self.m.erase(key)

func keys() -> Variant:
	var _this: Array[Variant] = self.m.keys()
	var tempResult: ArrayIterator = ArrayIterator.new(_this)

	return tempResult

func iterator() -> Variant:
	var _this: Array[Variant] = self.m.values()
	var tempResult: ArrayIterator = ArrayIterator.new(_this)

	return tempResult

func keyValueIterator() -> Variant:
	return MapKeyValueIterator.new(self)

func copy() -> ObjectMap:
	var result: ObjectMap = ObjectMap.new()

	result.m = self.m.duplicate(false)

	return result

func toString() -> String:
	var result: String = "["
	var first: bool = true
	var _g_map: Variant = self
	var _g_keys: Variant = self.keys()

	while (_g_keys.get("hasNext").call()):
		var _g_value
		var _g_key
		var key = _g_keys.get("next").call()
		_g_value = _g_map.__get(key)
		_g_key = key
		var key2 = _g_key
		var value = _g_value
		var tempString
		if (first):
			tempString = ""
		else:
			tempString = ", "
		result += (tempString) + (str(key2) + " => " + str(value))
		if (first):
			first = false

	return result + "]"

func clear() -> void:
	self.m.clear()

