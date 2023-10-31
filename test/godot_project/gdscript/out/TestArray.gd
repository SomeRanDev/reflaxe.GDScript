class_name TestArray

func _init():
	pass

static func test():
	var arr = []

	if true:
		var cond = arr.size() == 0
		assert(cond, "Test assert failed.")

	arr.push_back(0 + 1)
	arr.push_back(1 + 1)
	arr.push_back(2 + 1)

	if true:
		var cond = arr.size() == 3
		assert(cond, "Test assert failed.")
	if true:
		var cond = (arr + [4, 5, 6]).size() == 6
		assert(cond, "Test assert failed.")
	if true:
		var cond = arr.has(3)
		assert(cond, "Test assert failed.")
	if true:
		var cond = !arr.has(5)
		assert(cond, "Test assert failed.")

	assert(arr == arr, "Test assert failed.")

	if true:
		var tempRight
		if true:
			var _g = []
			if true:
				var _g1 = 0
				while (_g1 < arr.size()):
					var v = arr[_g1]
					_g1 += 1
					_g.push_back(v)
			tempRight = _g
		var cond = arr == tempRight
		assert(cond, "Test assert failed.")
	if true:
		var tempArray
		if true:
			var temp = func(i):
				return i != 1
			var result = []
			if true:
				var _g = 0
				var _g1 = arr
				while (_g < _g1.size()):
					var v = _g1[_g]
					_g += 1
					if (temp.call(v)):
						result.push_back(v)
			tempArray = result
		var cond = tempArray.size() == 2
		assert(cond, "Test assert failed.")
	if true:
		var cond = arr.find(2) == 1
		assert(cond, "Test assert failed.")

	if (0 < 0):
		arr.insert(arr.size() + 1 + 0, 0)
	else:
		arr.insert(0, 0)

	null

	if true:
		var cond = arr.size() == 4
		assert(cond, "Test assert failed.")

	assert(arr[0] == 0, "Test assert failed.")
	assert(arr[2] == 2, "Test assert failed.")

	if (-1 < 0):
		arr.insert(arr.size() + 1 + ((-1)), 4)
	else:
		arr.insert(-1, 4)

	null

	if true:
		var cond = arr.size() == 5
		assert(cond, "Test assert failed.")

	assert(arr[4] == 4, "Test assert failed.")
	assert(arr[2] == 2, "Test assert failed.")

	var total = 0
	var it_current = 0

	while (it_current < arr.size()):
		var tempIndex
		it_current += 1
		tempIndex = it_current - 1
		total += arr[tempIndex]

	assert(total == 10, "Test assert failed.")

	if true:
		var tempLeft
		if true:
			var result = ""
			var len = arr.size()
			if true:
				var _g = 0
				var _g1 = len
				while (_g < _g1):
					var tempVar
					if true:
						_g += 1
						tempVar = _g - 1
					var i = tempVar
					var tempRight1
					if (i == len - 1):
						tempRight1 = ""
					else:
						tempRight1 = ", "
					result += str(arr[i]) + tempRight1
			tempLeft = result
		var cond = tempLeft == "0, 1, 2, 3, 4"
		assert(cond, "Test assert failed.")

	var tempArray1

	if true:
		var temp = func(i):
			return i * 2
		var result = []
		if true:
			var _g = 0
			while (_g < arr.size()):
				var v = arr[_g]
				_g += 1
				result.push_back(temp.call(v))
		tempArray1 = result

	var keyTotal = 0
	var doubleTotal = 0
	var kvit_current = 0

	while (kvit_current < tempArray1.size()):
		var o_value
		var o_key
		o_value = tempArray1[kvit_current]
		var tempRight2
		kvit_current += 1
		tempRight2 = kvit_current - 1
		o_key = tempRight2
		keyTotal += o_key
		doubleTotal += o_value

	assert(keyTotal == 10, "Test assert failed.")
	assert(doubleTotal == 20, "Test assert failed.")

	var stack = [84, 29, 655]

	if true:
		var cond = stack.pop_back() == 655
		assert(cond, "Test assert failed.")
	if true:
		var cond = stack.size() == 2
		assert(cond, "Test assert failed.")

	stack.push_back(333)
	assert(stack[2] == 333, "Test assert failed.")

	var tempCond

	if true:
		var index = stack.find(84)
		if (index >= 0):
			stack.remove_at(index)
			tempCond = true
		else:
			tempCond = false

	if tempCond:
		if true:
			var cond = stack.size() == 2
			assert(cond, "Test assert failed.")
		assert(stack[0] == 29, "Test assert failed.")
	else:
		assert(false, "Test assert failed.")

	var ordered = [3, 6, 9, 12]

	ordered.reverse()
	assert(ordered == [12, 9, 6, 3], "Test assert failed.")

	if true:
		var cond = ordered.pop_front() == 12
		assert(cond, "Test assert failed.")

	var newArr = [22, 44, 66, 88]

	if true:
		var cond = newArr.slice(1) == [44, 66, 88]
		assert(cond, "Test assert failed.")
	if true:
		var cond = newArr.slice(2, 3) == [66]
		assert(cond, "Test assert failed.")

	var sortable = [2, 7, 1, 4, 0, 4]
	var f = func(a, b):
		return a - b

	sortable.sort_custom(func(a, b):
		return f.call(a, b) < 0)
	assert(sortable == [0, 1, 2, 4, 4, 7], "Test assert failed.")

	if true:
		var tempLeft1
		if true:
			var pos = 2
			var result = []
			if (pos < 0):
				pos = 0
			var i = pos + 1 - 1
			if (i >= sortable.size()):
				i = sortable.size() - 1
			while (i >= pos):
				result.push_back(sortable[pos])
				sortable.remove_at(pos)
				i -= 1
			tempLeft1 = result
		var cond = tempLeft1 == [2]
		assert(cond, "Test assert failed.")
	if true:
		var tempLeft2
		if true:
			var pos = 1
			var result = []
			if (pos < 0):
				pos = 0
			var i = pos + 3 - 1
			if (i >= sortable.size()):
				i = sortable.size() - 1
			while (i >= pos):
				result.push_back(sortable[pos])
				sortable.remove_at(pos)
				i -= 1
			tempLeft2 = result
		var cond = tempLeft2 == [1, 4, 4]
		assert(cond, "Test assert failed.")
	if true:
		var cond = str(sortable) == "[0, 7]"
		assert(cond, "Test assert failed.")

	var unfinished = [3, 4, 5]

	unfinished.push_front(2)
	unfinished.push_front(1)
	assert(unfinished == [1, 2, 3, 4, 5], "Test assert failed.")

