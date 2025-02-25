class_name TestArray

func _init() -> void:
	pass

static func test() -> void:
	var arr: Array[int] = []

	if true:
		var cond: bool = arr.size() == 0
		assert(cond, "Test assert failed.")

	arr.push_back(0 + 1)
	arr.push_back(1 + 1)
	arr.push_back(2 + 1)

	if true:
		var cond: bool = arr.size() == 3
		assert(cond, "Test assert failed.")
	if true:
		var cond: bool = (arr + ([4, 5, 6] as Array[int])).size() == 6
		assert(cond, "Test assert failed.")
	if true:
		var cond: bool = arr.has(3)
		assert(cond, "Test assert failed.")
	if true:
		var cond: bool = !arr.has(5)
		assert(cond, "Test assert failed.")

	assert(arr == arr, "Test assert failed.")

	if true:
		var tempRight
		if true:
			var _g: Array[int] = ([] as Array[int])
			if true:
				var _g1: int = 0
				while (_g1 < arr.size()):
					var v: int = arr[_g1]
					_g1 += 1
					_g.push_back(v)
			tempRight = _g
		var cond: bool = arr == tempRight
		assert(cond, "Test assert failed.")
	if true:
		var tempArray
		if true:
			var temp = func(i: int) -> bool:
				return i != 1
			var result: Array[int] = ([] as Array[int])
			if true:
				var _g: int = 0
				while (_g < arr.size()):
					var v: int = arr[_g]
					_g += 1
					if (temp.call(v)):
						result.push_back(v)
			tempArray = result
		var cond: bool = (tempArray).size() == 2
		assert(cond, "Test assert failed.")
	if true:
		var cond: bool = arr.find(2) == 1
		assert(cond, "Test assert failed.")

	if (0 < 0):
		arr.insert(arr.size() + 1 + 0, 0)
	else:
		arr.insert(0, 0)

	null

	if true:
		var cond: bool = arr.size() == 4
		assert(cond, "Test assert failed.")

	assert(arr[0] == 0, "Test assert failed.")
	assert(arr[2] == 2, "Test assert failed.")

	if (-1 < 0):
		arr.insert(arr.size() + 1 + (-1), 4)
	else:
		arr.insert(-1, 4)

	null

	if true:
		var cond: bool = arr.size() == 5
		assert(cond, "Test assert failed.")

	assert(arr[4] == 4, "Test assert failed.")
	assert(arr[2] == 2, "Test assert failed.")

	var total: int = 0
	var it_current: int = 0

	while (it_current < arr.size()):
		var tempIndex
		it_current += 1
		tempIndex = it_current - 1
		total += arr[tempIndex]

	assert(total == 10, "Test assert failed.")

	if true:
		var tempLeft
		if true:
			var result: String = ""
			var len: int = arr.size()
			if true:
				var _g: int = 0
				var _g1: int = len
				while (_g < _g1):
					var tempNumber
					if true:
						_g += 1
						tempNumber = _g - 1
					var i: int = tempNumber
					var tempString
					if (i == len - 1):
						tempString = ""
					else:
						tempString = ", "
					result += str(arr[i]) + (tempString)
			tempLeft = result
		var cond: bool = tempLeft == "0, 1, 2, 3, 4"
		assert(cond, "Test assert failed.")

	var tempArray1

	if true:
		var temp = func(i: int) -> int:
			return i * 2
		var result: Array[int] = ([] as Array[int])
		if true:
			var _g: int = 0
			while (_g < arr.size()):
				var v: int = arr[_g]
				_g += 1
				result.push_back(temp.call(v))
		tempArray1 = result

	var keyTotal: int = 0
	var doubleTotal: int = 0
	var kvit_current: int = 0

	while (kvit_current < tempArray1.size()):
		var o_value
		var o_key
		o_value = tempArray1[kvit_current]
		var tempRight1
		kvit_current += 1
		tempRight1 = kvit_current - 1
		o_key = tempRight1
		keyTotal += o_key
		doubleTotal += o_value

	assert(keyTotal == 10, "Test assert failed.")
	assert(doubleTotal == 20, "Test assert failed.")

	var stack: Array[int] = ([84, 29, 655] as Array[int])

	if true:
		var cond: bool = stack.pop_back() == 655
		assert(cond, "Test assert failed.")
	if true:
		var cond: bool = stack.size() == 2
		assert(cond, "Test assert failed.")

	stack.push_back(333)
	assert(stack[2] == 333, "Test assert failed.")

	var tempBool
	var index: int = stack.find(84)

	if (index >= 0):
		stack.remove_at(index)
		tempBool = true
	else:
		tempBool = false
	if (tempBool):
		if true:
			var cond: bool = stack.size() == 2
			assert(cond, "Test assert failed.")
		assert(stack[0] == 29, "Test assert failed.")
	else:
		assert(false, "Test assert failed.")

	var ordered: Array[int] = ([3, 6, 9, 12] as Array[int])

	ordered.reverse()
	assert(ordered == ([12, 9, 6, 3] as Array[int]), "Test assert failed.")

	if true:
		var cond: bool = ordered.pop_front() == 12
		assert(cond, "Test assert failed.")

	var newArr: Array[int] = ([22, 44, 66, 88] as Array[int])

	if true:
		var cond: bool = newArr.slice(1) == ([44, 66, 88] as Array[int])
		assert(cond, "Test assert failed.")
	if true:
		var cond: bool = newArr.slice(2, 3) == ([66] as Array[int])
		assert(cond, "Test assert failed.")

	var sortable: Array[int] = ([2, 7, 1, 4, 0, 4] as Array[int])
	var f = func(a: int, b: int) -> int:
		return a - b

	sortable.sort_custom(func(a: int, b: int) -> bool:
		return f.call(a, b) < 0)
	assert(sortable == ([0, 1, 2, 4, 4, 7] as Array[int]), "Test assert failed.")

	if true:
		var tempLeft1
		if true:
			var pos: int = 2
			var result: Array[int] = ([] as Array[int])
			if (pos < 0):
				pos = 0
			var i: int = pos + 1 - 1
			if (i >= sortable.size()):
				i = sortable.size() - 1
			while (i >= pos):
				result.push_back(sortable[pos])
				sortable.remove_at(pos)
				i -= 1
			tempLeft1 = result
		var cond: bool = tempLeft1 == ([2] as Array[int])
		assert(cond, "Test assert failed.")
	if true:
		var tempLeft2
		if true:
			var pos: int = 1
			var result: Array[int] = ([] as Array[int])
			if (pos < 0):
				pos = 0
			var i: int = pos + 3 - 1
			if (i >= sortable.size()):
				i = sortable.size() - 1
			while (i >= pos):
				result.push_back(sortable[pos])
				sortable.remove_at(pos)
				i -= 1
			tempLeft2 = result
		var cond: bool = tempLeft2 == ([1, 4, 4] as Array[int])
		assert(cond, "Test assert failed.")
	if true:
		var cond: bool = str(sortable) == "[0, 7]"
		assert(cond, "Test assert failed.")

	var unfinished: Array[int] = ([3, 4, 5] as Array[int])

	unfinished.push_front(2)
	unfinished.push_front(1)
	assert(unfinished == ([1, 2, 3, 4, 5] as Array[int]), "Test assert failed.")

