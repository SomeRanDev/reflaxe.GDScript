class_name MyHash_Impl_

func _init() -> void:
	pass

static func _new() -> StringMap:
	var this1: StringMap = StringMap.new()

	return this1

static func __set(this1: StringMap, k: String, v) -> void:
	this1.__set(k, v)

static func __get(this1: StringMap, k: String):
	return this1.__get(k)

static func toString(this1: StringMap) -> String:
	return this1.toString()

static func fromStringArray(arr: Array[String]) -> StringMap:
	var this1: StringMap = StringMap.new()
	var tempMyHash: StringMap = this1
	var i: int = 0

	while (i < arr.size()):
		var tempIndex
		i += 1
		tempIndex = i - 1
		var k: String = arr[tempIndex]
		var tempIndex1
		i += 1
		tempIndex1 = i - 1
		var v: String = arr[tempIndex1]
		tempMyHash.__set(k, v)

	return tempMyHash

static func fromArray(arr: Array[Variant]) -> StringMap:
	var this1: StringMap = StringMap.new()
	var tempMyHash: StringMap = this1
	var i: int = 0

	while (i < arr.size()):
		var tempIndex
		i += 1
		tempIndex = i - 1
		var k = arr[tempIndex]
		var tempIndex1
		i += 1
		tempIndex1 = i - 1
		var v = arr[tempIndex1]
		var k2: String = str("_s" + str(k))
		tempMyHash.__set(k2, v)

	return tempMyHash

