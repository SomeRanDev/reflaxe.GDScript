class_name haxe_iterators_MapKeyValueIterator

var map: Variant
var keys: Variant

func _init(map2: Variant) -> void:
	self.map = map2
	self.keys = map2.keys()

func hasNext() -> bool:
	return self.keys.get("hasNext").call()

func next() -> Variant:
	var key = self.keys.get("next").call()

	return {
		"value": self.map.__get(key),
		"key": key
	}
