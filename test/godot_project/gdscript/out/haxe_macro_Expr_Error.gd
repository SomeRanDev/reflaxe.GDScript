extends Exception
class_name Error

var pos: Variant

func _init(message: String, pos2: Variant, previous = null) -> void:
	super(message, previous)
	self.pos = pos2

