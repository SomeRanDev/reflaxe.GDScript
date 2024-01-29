class_name OtherClass

static var str: String = ""
static var add = func():
	OtherClass.str += "|"

func _init():
	pass

static func clear() -> void:
	OtherClass.str = ""

