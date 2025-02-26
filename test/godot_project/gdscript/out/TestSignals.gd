class_name TestSignals

func _init() -> void:
	pass

signal my_signal(i: int)

func do_test() -> void:
	connect("my_signal", self.test2)
	emit_signal("my_signal", 123)

func test2(i: int) -> void:
	assert(i == 123, "Test assert failed.")

static func test() -> void:
	var t: TestSignals = TestSignals.new()

	t.do_test()
