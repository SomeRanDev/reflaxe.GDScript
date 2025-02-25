class_name MyClass

var internalProp: int = 1

func _init() -> void:
	self.internalProp = 1

func get_myProp() -> int:
	return self.internalProp

func set_myProp(v: int) -> int:
	self.internalProp = v

	return self.internalProp

