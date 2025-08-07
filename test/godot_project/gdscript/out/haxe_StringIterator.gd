class_name haxe_iterators_StringIterator

var offset: int = 0
var s: String

func _init(s2: String) -> void:
	self.s = s2

func hasNext() -> bool:
	return self.offset < self.s.length()

func next() -> int:
	var s2: String = self.s

	self.offset += 1

	var tempNumber: int = self.offset - 1
	var index: int = tempNumber
	var tempResult: int = s2.unicode_at.call(index)

	return tempResult

