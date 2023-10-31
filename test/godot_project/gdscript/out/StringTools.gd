class_name StringTools

func _init():
	pass

static func startsWith(s, start):
	var tempLeft

	if (0 < 0):
		tempLeft = s.rfind(start)
	else:
		var tempString
		if true:
			var endIndex = 0 + s.length()
			if (endIndex < 0):
				tempString = s.substr(0)
			else:
				tempString = s.substr(0, endIndex - 0)
		tempLeft = tempString.rfind(start)

	return s.length() >= start.length() && tempLeft == 0

