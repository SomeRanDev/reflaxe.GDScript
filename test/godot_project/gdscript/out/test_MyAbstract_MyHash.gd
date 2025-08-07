class_name MyHash_Impl_

func _init() -> void:
	pass

static func _new() -> haxe_ds_StringMap:
	var this1: haxe_ds_StringMap = haxe_ds_StringMap.new()

	return this1

static func __set(this1: haxe_ds_StringMap, k: String, v) -> void:
	this1.__set(k, v)

static func __get(this1: haxe_ds_StringMap, k: String):
	return this1.__get(k)

static func toString(this1: haxe_ds_StringMap) -> String:
	return this1.toString()

static func fromStringArray(arr: Array[String]) -> haxe_ds_StringMap:
	var this1: haxe_ds_StringMap = haxe_ds_StringMap.new()
	var tempMyHash: haxe_ds_StringMap = this1
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

static func fromArray(arr: Array[Variant]) -> haxe_ds_StringMap:
	var this1: haxe_ds_StringMap = haxe_ds_StringMap.new()
	var tempMyHash: haxe_ds_StringMap = this1
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

