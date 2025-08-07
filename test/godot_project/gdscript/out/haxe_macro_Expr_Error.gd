extends haxe_Exception
class_name haxe_macro_Error

var pos: Variant

func _init(message: String, pos2: Variant, previous = null) -> void:
	super(message, previous)
	self.pos = pos2

