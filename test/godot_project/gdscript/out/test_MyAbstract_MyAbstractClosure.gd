class_name MyAbstractClosure_Impl_

func _init() -> void:
	pass

static func _new(value: String) -> String:
	var this1: String = value

	return this1

static func test(this1: String):
	var fn = func() -> String:
		return this1

	return fn

static func setVal(this1: String, v: String) -> void:
	this1 = v

