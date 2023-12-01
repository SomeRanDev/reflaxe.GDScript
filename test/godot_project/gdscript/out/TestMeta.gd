@tool
class_name TestMeta

var prop: int

@export_enum("Hello", "World")
var enumField: int

func _init() -> void:
	self.enumField = 0
	self.prop = 123

static func test() -> void:
	var tm: TestMeta = TestMeta.new()
	var cond: bool = tm.prop == 123

	assert(cond, "Test assert failed.")

