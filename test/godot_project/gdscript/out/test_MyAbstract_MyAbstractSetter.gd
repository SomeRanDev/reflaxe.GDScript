class_name MyAbstractSetter_Impl_

func _init() -> void:
	pass

static func _new():
	var this1 = {
	}

	return this1

static func get_value(this1) -> String:
	return this1.value

static func set_value(this1, s: String) -> String:
	this1.value = s

	return s

