class_name MySpecialString_Impl_

func _init() -> void:
	pass

static func substr(this1: String, i: int, len = null) -> String:
	var tempResult

	if (len == null):
		tempResult = this1.substr(i)
	else:
		tempResult = this1.substr(i, len)

	return tempResult

static func toNormal(t: String, value: String) -> String:
	var this1: String = value
	var tempResult: String = this1

	return tempResult

