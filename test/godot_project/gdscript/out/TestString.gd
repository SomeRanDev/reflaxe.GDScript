class_name TestString

func _init():
	pass

static func test() -> void:
	var str: String = "Test"

	assert(str == "Test", "Test assert failed.")

	if true:
		var cond: bool = str.length() == 4
		assert(cond, "Test assert failed.")
	if true:
		var cond: bool = str == "Test"
		assert(cond, "Test assert failed.")
	if true:
		var cond: bool = char(70) == "F"
		assert(cond, "Test assert failed.")
	if true:
		var tempMaybeNumber
		if (1 >= 0 && 1 < str.length()):
			tempMaybeNumber = str.unicode_at(1)
		else:
			tempMaybeNumber = null
		var cond: bool = (tempMaybeNumber) == 101
		assert(cond, "Test assert failed.")
	if true:
		var cond: bool = str.find("es") == 1
		assert(cond, "Test assert failed.")
	if true:
		var cond: bool = str.find("Hey") == -1
		assert(cond, "Test assert failed.")
	if true:
		var cond: bool = str.find("Te", 2) == -1
		assert(cond, "Test assert failed.")
	if true:
		var tempLeft
		if true:
			var startIndex: int = -1
			if (startIndex < 0):
				tempLeft = str.rfind("Te")
			else:
				var tempString
				if true:
					var endIndex: int = startIndex + str.length()
					if (endIndex < 0):
						tempString = str.substr(0)
					else:
						tempString = str.substr(0, endIndex - 0)
				tempLeft = (tempString).rfind("Te")
		var cond: bool = tempLeft == 0
		assert(cond, "Test assert failed.")
	if true:
		var cond: bool = Array(str.split("s"))[0] == "Te"
		assert(cond, "Test assert failed.")
	if true:
		var cond: bool = Array(str.split("e")).size() == 2
		assert(cond, "Test assert failed.")

	var str2: String = "Hello, World!"

	if true:
		var cond: bool = str2.substr(7, 5) == "World"
		assert(cond, "Test assert failed.")
	if true:
		var tempString1
		if (12 < 0):
			tempString1 = str2.substr(7)
		else:
			tempString1 = str2.substr(7, 12 - 7)
		var cond: bool = (tempString1) == "World"
		assert(cond, "Test assert failed.")
	if true:
		var cond: bool = str2.to_lower() == "hello, world!"
		assert(cond, "Test assert failed.")
	if true:
		var cond: bool = str2.to_upper() == "HELLO, WORLD!"
		assert(cond, "Test assert failed.")

