class_name TestStd

func _init():
	pass

static func test():
	var a = A.new()
	var b = B.new()

	if true:
		var cond = (a is A)
		assert(cond, "Test assert failed.")
	if true:
		var cond = (b is B)
		assert(cond, "Test assert failed.")
	if true:
		var cond = !(a is B)
		assert(cond, "Test assert failed.")
	if true:
		var cond = !(b is A)
		assert(cond, "Test assert failed.")

	var c = (b as C)

	assert(c == null, "Test assert failed.")

	if true:
		var cond = str(123) == "123"
		assert(cond, "Test assert failed.")
	if true:
		var cond = str(false) == "false"
		assert(cond, "Test assert failed.")
	if true:
		var cond = StringTools.startsWith(str(a), "<RefCounted#")
		assert(cond, "Test assert failed.")
	if true:
		var cond = int(2.3) == 2
		assert(cond, "Test assert failed.")
	if true:
		var cond = int(999.99) == 999
		assert(cond, "Test assert failed.")
	if true:
		var cond = "123".to_int() == 123
		assert(cond, "Test assert failed.")

	var input = "1.5".to_float()

	assert(abs(1.5 - input) < 0.0001, "Test assert failed.")

	var r = floor(randf() * 10)

	assert(r >= 0 && r < 10, "Test assert failed.")

