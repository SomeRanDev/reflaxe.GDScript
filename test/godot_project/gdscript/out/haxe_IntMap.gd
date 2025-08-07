class_name haxe_ds_IntMap

var m: Dictionary[int, Variant]

func _init() -> void:
	self.m = {}

func __set(key: int, value) -> void:
	self.m.set(key, value)

func __get(key: int):
	var tempResult

	if (self.m.has(key)):
		tempResult = self.m.get(key)
	else:
		tempResult = null

	return tempResult

func exists(key: int) -> bool:
	return self.m.has(key)

func remove(key: int) -> bool:
	return self.m.erase(key)

func keys() -> Variant:
	var _this: Array[int] = self.m.keys()
	var tempResult: haxe_iterators_ArrayIterator = haxe_iterators_ArrayIterator.new(_this)

	return tempResult

func iterator() -> Variant:
	var _this: Array[Variant] = self.m.values()
	var tempResult: haxe_iterators_ArrayIterator = haxe_iterators_ArrayIterator.new(_this)

	return tempResult

func keyValueIterator() -> Variant:
	return haxe_iterators_MapKeyValueIterator.new(self)

func copy() -> haxe_ds_IntMap:
	var result: haxe_ds_IntMap = haxe_ds_IntMap.new()

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
		var key: int = _g_keys.get("next").call()
		_g_value = _g_map.__get(key)
		_g_key = key
		var key2: int = _g_key
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

