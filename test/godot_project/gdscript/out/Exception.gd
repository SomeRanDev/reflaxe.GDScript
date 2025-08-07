class_name haxe_Exception

var _message: String
var _previous
var _native

func _init(message2: String, previous2 = null, native2 = null) -> void:
	self._message = message2
	self._previous = previous2
	self._native = native2

func get_message() -> String:
	return self._message

func get_stack() -> Array[Variant]:
	return ([] as Array[Variant])

func get_previous():
	return self._previous

func get_native():
	return self._native

func unwrap():
	return self._native

func toString() -> String:
	return self._message

func details() -> String:
	return self._message

static func caught(value) -> haxe_Exception:
	var tempString

	if (value == null):
		tempString = "null"
	else:
		tempString = str(value)

	return haxe_Exception.new(tempString)

static func thrown(value):
	return value

