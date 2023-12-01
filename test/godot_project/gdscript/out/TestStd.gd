class_name TestStd

func _init():
	pass

static func test() -> void:
	var a: A = A.new()
	var b: B = B.new()

	if true:
		var cond: bool = ((a as Variant) is A)
		assert(cond, "Test assert failed.")
	if true:
		var cond: bool = ((b as Variant) is B)
		assert(cond, "Test assert failed.")
	if true:
		var cond: bool = !((a as Variant) is B)
		assert(cond, "Test assert failed.")
	if true:
		var cond: bool = !((b as Variant) is A)
		assert(cond, "Test assert failed.")

	var c: C = (b as C)

	assert(c == null, "Test assert failed.")

	if true:
		var cond: bool = str(123) == "123"
		assert(cond, "Test assert failed.")
	if true:
		var cond: bool = str(false) == "false"
		assert(cond, "Test assert failed.")
	if true:
		var cond: bool = StringTools.startsWith(str(a), "<RefCounted#")
		assert(cond, "Test assert failed.")
	if true:
		var cond: bool = int(2.3) == 2
		assert(cond, "Test assert failed.")
	if true:
		var cond: bool = int(999.99) == 999
		assert(cond, "Test assert failed.")
	if true:
		var cond: bool = "123".to_int() == 123
		assert(cond, "Test assert failed.")

	var input: float = "1.5".to_float()

	assert(abs(1.5 - input) < 0.0001, "Test assert failed.")

	var r: int = floor(randf() * 10)

	assert(r >= 0 && r < 10, "Test assert failed.")

