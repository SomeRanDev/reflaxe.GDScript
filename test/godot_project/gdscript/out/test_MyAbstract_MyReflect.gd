class_name MyReflect_Impl_

func _init() -> void:
	pass

static func arrayAccess(this1: Variant, key: String):
	return this1.get(key)

static func arrayWrite(this1: Variant, key: String, value):
	Reflect.setField(this1, key, value)

	return value

