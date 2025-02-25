class_name StringTools

func _init() -> void:
	pass

static func startsWith(s: String, start: String) -> bool:
	var tempNumber

	if (0 < 0):
		tempNumber = s.rfind(start)
	else:
		var tempString
		var endIndex: int = 0 + s.length()
		if (endIndex < 0):
			tempString = s.substr(0)
		else:
			tempString = s.substr(0, endIndex - 0)
		tempNumber = (tempString).rfind(start)

	return s.length() >= start.length() && (tempNumber) == 0

