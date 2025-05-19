class_name MyAbstractCounter_Impl_

static var counter: int = 0

func _init() -> void:
	pass

static func _new(v: int) -> int:
	var this1: int = v

	counter += 1

	return this1

static func fromInt(v: int) -> int:
	var this1: int = v

	counter += 1

	var tempResult: int = this1

	return tempResult

static func getValue(this1: int) -> int:
	return this1 + 1

