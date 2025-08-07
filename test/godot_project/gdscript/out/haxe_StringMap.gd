class_name haxe_ds_StringMap

var m: Dictionary[String, Variant]

func _init() -> void:
	self.m = {}

func __set(key: String, value) -> void:
	self.m.set(key, value)

func __get(key: String):
	var tempResult

	if (self.m.has(key)):
		tempResult = self.m.get(key)
	else:
		tempResult = null

	return tempResult

func exists(key: String) -> bool:
	return self.m.has(key)

func remove(key: String) -> bool:
	return self.m.erase(key)

func keys() -> Variant:
	var _this: Array[String] = self.m.keys()
	var tempResult: haxe_iterators_ArrayIterator = haxe_iterators_ArrayIterator.new(_this)

	return tempResult

func iterator() -> Variant:
	var _this: Array[Variant] = self.m.values()
	var tempResult: haxe_iterators_ArrayIterator = haxe_iterators_ArrayIterator.new(_this)

	return tempResult

func keyValueIterator() -> Variant:
	return haxe_iterators_MapKeyValueIterator.new(self)

func copy() -> haxe_ds_StringMap:
	var result: haxe_ds_StringMap = haxe_ds_StringMap.new()

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
		var key: String = _g_keys.get("next").call()
		_g_value = _g_map.__get(key)
		_g_key = key
		var key2: String = _g_key
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
