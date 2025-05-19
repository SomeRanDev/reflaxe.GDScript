class_name ClassWithHashCode

var i: int

func _init(i2: int) -> void:
	self.i = i2

func hashCode() -> int:
	return self.i

