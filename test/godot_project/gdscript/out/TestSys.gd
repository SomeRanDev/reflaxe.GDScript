class_name TestSys

func _init():
	pass

static func test():
	if true:
		var cond = 0 == 0
		assert(cond, "Test assert failed.")

	var first = (Time.get_ticks_msec() * 1000)

	OS.delay_msec(0.1 * 1000)

	if true:
		var cond = (Time.get_ticks_msec() * 1000) - first > 10000
		assert(cond, "Test assert failed.")

