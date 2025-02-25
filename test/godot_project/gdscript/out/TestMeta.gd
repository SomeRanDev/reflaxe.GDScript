@tool
class_name TestMeta

var prop: int = 123
@export_enum("Hello", "World")
var enumField: int = 0

func _init() -> void:
	self.prop = 123

static func test() -> void:
	var tm: TestMeta = TestMeta.new()
	var cond: bool = tm.prop == 123

	assert(cond, "Test assert failed.")

