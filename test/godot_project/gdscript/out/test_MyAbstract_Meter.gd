class_name Meter_Impl_

func _init() -> void:
	pass

static func _new(f: float) -> float:
	var this1: float = f

	return this1

static func __get(this1: float) -> float:
	return this1

static func toString(this1: float) -> String:
	return str(this1) + "m"

