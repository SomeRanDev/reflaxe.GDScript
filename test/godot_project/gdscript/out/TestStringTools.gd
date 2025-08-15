class_name TestStringTools

func _init() -> void:
	pass

static func test() -> void:
	var cond: bool = StringTools.hex(123, null) == "7B"

	assert(cond, "Test assert failed.")

