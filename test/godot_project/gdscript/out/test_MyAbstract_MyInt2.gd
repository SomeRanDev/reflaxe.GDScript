class_name MyInt2_Impl_

func _init() -> void:
	pass

static func _new(v: int) -> int:
	var this1: int = v

	return this1

static func __get(this1: int) -> int:
	return this1

static func invert(this1: int) -> int:
	var this2: int = -this1
	var tempResult: int = this2

	return tempResult

static func incr(this1: int) -> void:
	this1 += 1

