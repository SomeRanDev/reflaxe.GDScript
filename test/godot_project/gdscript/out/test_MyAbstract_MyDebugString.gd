class_name MyDebugString_Impl_

func _init() -> void:
	pass

static func _new(s: String) -> String:
	var this1: String = s

	return this1

static func substr(this1: String, i: int, len = null) -> String:
	return this1.substr(i)

