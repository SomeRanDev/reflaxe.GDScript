class_name Kilometer_Impl_

func _init() -> void:
	pass

static func _new(f: float) -> float:
	var this1: float = f

	return this1

static func toString(this1: float) -> String:
	return str(this1) + "km"

static func fromMeter(m: float) -> float:
	var this1: float = m / 1000.
	var tempResult: float = this1

	return tempResult

