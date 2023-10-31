class_name TestString

func _init():
	pass

static func test():
	var _str = "Test"

	assert(_str == "Test", "Test assert failed.")

	if true:
		var cond = _str.length() == 4
		assert(cond, "Test assert failed.")
	if true:
		var cond = _str == "Test"
		assert(cond, "Test assert failed.")
	if true:
		var cond = char(70) == "F"
		assert(cond, "Test assert failed.")
	if true:
		var tempLeft
		if (1 >= 0 && 1 < _str.length()):
			tempLeft = _str.unicode_at(1)
		else:
			tempLeft = null
		var cond = tempLeft == 101
		assert(cond, "Test assert failed.")
	if true:
		var cond = _str.find("es") == 1
		assert(cond, "Test assert failed.")
	if true:
		var cond = _str.find("Hey") == -1
		assert(cond, "Test assert failed.")
	if true:
		var cond = _str.find("Te", 2) == -1
		assert(cond, "Test assert failed.")
	if true:
		var tempLeft1
		if true:
			var startIndex = -1
			if (startIndex < 0):
				tempLeft1 = _str.rfind("Te")
			else:
				var tempString
				if true:
					var endIndex = startIndex + _str.length()
					if (endIndex < 0):
						tempString = _str.substr(0)
					else:
						tempString = _str.substr(0, endIndex - 0)
				tempLeft1 = tempString.rfind("Te")
		var cond = tempLeft1 == 0
		assert(cond, "Test assert failed.")
	if true:
		var cond = Array(_str.split("s"))[0] == "Te"
		assert(cond, "Test assert failed.")
	if true:
		var cond = Array(_str.split("e")).size() == 2
		assert(cond, "Test assert failed.")

	var str2 = "Hello, World!"

	if true:
		var cond = str2.substr(7, 5) == "World"
		assert(cond, "Test assert failed.")
	if true:
		var tempLeft2
		if (12 < 0):
			tempLeft2 = str2.substr(7)
		else:
			tempLeft2 = str2.substr(7, 12 - 7)
		var cond = tempLeft2 == "World"
		assert(cond, "Test assert failed.")
	if true:
		var cond = str2.to_lower() == "hello, world!"
		assert(cond, "Test assert failed.")
	if true:
		var cond = str2.to_upper() == "HELLO, WORLD!"
		assert(cond, "Test assert failed.")

