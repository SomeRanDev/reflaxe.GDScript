class_name TestEnum

func _init() -> void:
	pass

static func test() -> void:
	var a: Variant = { "_index": 0 }
	var b: Variant = { "_index": 1, "i": 123 }
	var c: Variant = { "_index": 2, "s": "Test" }

	match (b._index):
		0:
			assert(false, "Test assert failed.")
		1:
			var _g: int = b.i
			if true:
				var i: int = _g
				assert(i == 123, "Test assert failed.")
		2:
			var _g: String = b.s
			if true:
				var s: String = _g
				assert(false, "Test assert failed.")
	match (c._index):
		0:
			assert(false, "Test assert failed.")
		1:
			var _g: int = c.i
			if true:
				var i: int = _g
				assert(false, "Test assert failed.")
		2:
			var _g: String = c.s
			if true:
				var s: String = _g
				assert(s == "Test", "Test assert failed.")

