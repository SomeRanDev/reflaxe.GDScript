@tool
class_name TestMeta

var prop

@export_enum("Hello", "World")
var enumField

func _init():
	self.enumField = 0
	self.prop = 123

static func test():
	var tm = TestMeta.new()
	var cond = tm.prop == 123

	assert(cond, "Test assert failed.")

