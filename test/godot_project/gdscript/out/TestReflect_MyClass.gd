class_name MyClass

var internalProp

func _init():
	self.internalProp = 1

func get_myProp():
	return self.internalProp

func set_myProp(v):
	self.internalProp = v

	return self.internalProp

