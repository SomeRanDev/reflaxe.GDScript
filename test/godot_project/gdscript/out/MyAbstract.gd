class_name MyAbstract_Impl_

func _init() -> void:
	pass

static func _new(x: int) -> int:
	var this1: int = x

	return this1

static func incr(this1: int) -> int:
	this1 += 1

	var tempResult: int = this1

	return tempResult

static func toInt(this1: int) -> int:
	return this1

