class_name TestSys

func _init():
	pass

static func test() -> void:
	if true:
		var cond: bool = 0 == 0
		assert(cond, "Test assert failed.")

	var first: float = (Time.get_ticks_msec() * 1000)

	OS.delay_msec(0.1 * 1000)

	if true:
		var cond: bool = (Time.get_ticks_msec() * 1000) - first > 10000
		assert(cond, "Test assert failed.")

