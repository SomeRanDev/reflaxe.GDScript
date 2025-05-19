class_name MyAbstractThatCallsAMember_Impl_

func _init() -> void:
	pass

static func _new(i: int) -> int:
	var this1: int = i

	this1 += 1

	return this1

static func bar(this1: int) -> void:
	this1 += 1

