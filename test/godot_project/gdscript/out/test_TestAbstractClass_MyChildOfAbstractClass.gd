extends MyAbstractClass
class_name MyChildOfAbstractClass

func _init() -> void:
	pass

func getNothing() -> void:
	pass

func getInt() -> int:
	return 123

func getBool() -> bool:
	return false

func getObject() -> MyObject:
	return MyObject.new()

