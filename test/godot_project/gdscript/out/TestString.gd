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
		var tempLeft
		if (1 >= 0 && 1 < str.length()):
			tempLeft = str.unicode_at(1)
		else:
			tempLeft = null
		var cond: bool = tempLeft == 101
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
		var tempLeft1
		if true:
			var startIndex: int = -1
			if (startIndex < 0):
				tempLeft1 = str.rfind("Te")
			else:
				var tempString
				if true:
					var endIndex: int = startIndex + str.length()
					if (endIndex < 0):
						tempString = str.substr(0)
					else:
						tempString = str.substr(0, endIndex - 0)
				tempLeft1 = tempString.rfind("Te")
		var cond: bool = tempLeft1 == 0
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
		var tempLeft2
		if (12 < 0):
			tempLeft2 = str2.substr(7)
		else:
			tempLeft2 = str2.substr(7, 12 - 7)
		var cond: bool = tempLeft2 == "World"
		assert(cond, "Test assert failed.")
	if true:
		var cond: bool = str2.to_lower() == "hello, world!"
		assert(cond, "Test assert failed.")
	if true:
		var cond: bool = str2.to_upper() == "HELLO, WORLD!"
		assert(cond, "Test assert failed.")

