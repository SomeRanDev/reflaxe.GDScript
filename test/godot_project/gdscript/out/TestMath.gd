class_name TestMath

func _init():
	pass

static func test():
	if true:
		var tempLeft
		if true:
			var v = 2 * pow(PI, 2)
			tempLeft = int(ceil(v))
		var cond = tempLeft == 20
		assert(cond, "Test assert failed.")
	if true:
		var cond = abs(-3) == 3
		assert(cond, "Test assert failed.")

	assert(3 == 3, "Test assert failed.")
	assert(1 == 1, "Test assert failed.")

	if true:
		var tempLeft1
		if true:
			var v = exp(1.0)
			tempLeft1 = int(ceil(v))
		var cond = tempLeft1 == 3
		assert(cond, "Test assert failed.")
	if true:
		var tempLeft2
		if true:
			var v = exp(1.0)
			tempLeft2 = int(floor(v))
		var cond = tempLeft2 == 2
		assert(cond, "Test assert failed.")

	assert(99 == 99, "Test assert failed.")

	if true:
		var cond = is_finite(12)
		assert(cond, "Test assert failed.")
	if true:
		var cond = is_nan(NAN)
		assert(cond, "Test assert failed.")
	if true:
		var cond = !is_finite(INF)
		assert(cond, "Test assert failed.")
	if true:
		var cond = !is_finite(-INF)
		assert(cond, "Test assert failed.")
	if true:
		var input = sin(PI)
		assert(abs(0.0 - input) < 0.0001, "Test assert failed.")
	if true:
		var input = cos(0)
		assert(abs(1 - input) < 0.0001, "Test assert failed.")
	if true:
		var input = tan(4)
		assert(abs(1.157821 - input) < 0.0001, "Test assert failed.")
	if true:
		var input = asin(1)
		assert(abs(1.570796 - input) < 0.0001, "Test assert failed.")
	if true:
		var input = acos(100)
		assert(abs(0 - input) < 0.0001, "Test assert failed.")
	if true:
		var input = atan(12)
		assert(abs(1.4876 - input) < 0.0001, "Test assert failed.")
	if true:
		var input = atan2(-3, 3)
		assert(abs(-0.78539 - input) < 0.0001, "Test assert failed.")
	if true:
		var input = log(10)
		assert(abs(2.30258 - input) < 0.0001, "Test assert failed.")
	if true:
		var cond = sqrt(25) == 5
		assert(cond, "Test assert failed.")
	if true:
		var cond = sqrt(100) == 10
		assert(cond, "Test assert failed.")

