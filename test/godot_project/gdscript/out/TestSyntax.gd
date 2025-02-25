class_name TestSyntax

var testField: int = 123

func _init() -> void:
	assert(self.testField == 123, "Test assert failed.")

static func test() -> void:
	assert(true, "Test assert failed.")
	assert(!false, "Test assert failed.")
	assert(1 + 1 == 2, "Test assert failed.")
	assert(1 - 1 == 0, "Test assert failed.")
	assert(2 * 2 == 4, "Test assert failed.")
	assert(10 / 2 == 5, "Test assert failed.")

	var myNull = null

	assert(myNull == null, "Test assert failed.")

	var obj: TestSyntax = TestSyntax.new()

	assert(obj == obj, "Test assert failed.")

	if true:
		var cond: bool = obj.testField == 123
		assert(cond, "Test assert failed.")

	var str: String = "World"

	str = "Hello, " + str
	str += "!"
	assert(str == "Hello, World!", "Test assert failed.")

	if (str != "Goodbye World!"):
		var num: int = 3
		assert(num > 1, "Test assert failed.")
		assert(num >= 3 && num >= 2, "Test assert failed.")
		assert(num == 3, "Test assert failed.")
		assert(num <= 3 && num <= 6, "Test assert failed.")
		assert(num < 4, "Test assert failed.")
	else:
		assert(false, "Test assert failed.")

	var num: int = 3

	assert((num & 1) == 1, "Test assert failed.")
	assert((num & 4) == 0, "Test assert failed.")
	assert((num | 8) == 11, "Test assert failed.")
	assert((num | 3) == 3, "Test assert failed.")
	assert(1 + 1 == 1 + 1, "Test assert failed.")

	var dict = {
		"hey": "Hey",
		"thing": obj,
		"number": 3
	}

	if true:
		var cond: bool = dict.hey == "Hey"
		assert(cond, "Test assert failed.")
	if true:
		var cond: bool = dict.number == 3
		assert(cond, "Test assert failed.")

	dict.pokemon = "Pikachu"

	if true:
		var cond: bool = dict.pokemon == "Pikachu"
		assert(cond, "Test assert failed.")

	var arr_0: int = 1
	var arr_1: int = 2
	var arr_2: int = 3

	assert(arr_1 == 2, "Test assert failed.")

	if true:
		var cond: bool = 3 == 3
		assert(cond, "Test assert failed.")

	var arr2: Array[int] = []
	var _bool: bool = true

	assert(_bool, "Test assert failed.")

	var mutNum = [1000]

	mutNum[0] += 1
	mutNum[0] += 1

	if true:
		var tempLeft
		if true:
			mutNum[0] += 1
			tempLeft = mutNum[0] - 1
		var cond: bool = tempLeft == 1002
		assert(cond, "Test assert failed.")
	if true:
		var tempLeft1
		if true:
			mutNum[0] -= 1
			tempLeft1 = mutNum[0]
		var cond: bool = tempLeft1 == 1002
		assert(cond, "Test assert failed.")
	if true:
		var tempLeft2
		if true:
			mutNum[0] -= 1
			tempLeft2 = mutNum[0]
		var cond: bool = tempLeft2 == 1001
		assert(cond, "Test assert failed.")

	assert(mutNum[0] == 1001, "Test assert failed.")

	var myFunc = func() -> void:
		mutNum[0] += 1

	myFunc.call()
	myFunc.call()
	assert(mutNum[0] == 1003, "Test assert failed.")

	var a: int = 2
	var tempNumber: int = a * a
	var blockVal: int = tempNumber

	assert(blockVal == 4, "Test assert failed.")

	if (blockVal == 4):
		assert(true, "Test assert failed.")
	else:
		assert(false, "Test assert failed.")

	var i: int = 0

	while true:
		var tempLeft3
		i += 1
		tempLeft3 = i - 1
		if !(tempLeft3 < 1000):
			break
		if (i == 800):
			assert(i / 80 == 10, "Test assert failed.")

	var j: int = 0

	while true:
		var tempRight
		assert(true, "Test assert failed.")
		tempRight = 6
		if !(j < tempRight):
			break
		assert(true, "Test assert failed.")
		j += 1

	var anotherNum: int = 3
	var anotherNum2: int = anotherNum

	assert(anotherNum == anotherNum2, "Test assert failed.")
	anotherNum += 10
	anotherNum2 = anotherNum
	assert(anotherNum == anotherNum2, "Test assert failed.")

