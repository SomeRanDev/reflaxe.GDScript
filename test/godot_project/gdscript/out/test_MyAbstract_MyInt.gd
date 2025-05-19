class_name MyInt_Impl_

func _init() -> void:
	pass

static func repeat(lhs: int, rhs: String) -> String:
	var s_b: String = ""
	var _g: int = 0
	var _g1: int = lhs

	while (_g < _g1):
		var tempNumber
		_g += 1
		tempNumber = _g - 1
		var i: int = tempNumber
		s_b += str(rhs)

	return s_b

static func cut(lhs: String, rhs: int) -> String:
	return lhs.substr(0, rhs)

