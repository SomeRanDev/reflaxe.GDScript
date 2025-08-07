class_name haxe_iterators_ArrayIterator

var array: Array[Variant]
var current: int = 0

func _init(array2: Array[Variant]) -> void:
	self.array = array2

func hasNext() -> bool:
	return self.current < self.array.size()

func next():
	self.current += 1

	var tempIndex: int = self.current - 1

	return self.array[tempIndex]
