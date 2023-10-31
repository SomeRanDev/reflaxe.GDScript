class_name TestEnum

func _init():
	pass

static func test():
	var a = { "_index": 0 }
	var b = { "_index": 1, "i": 123 }
	var c = { "_index": 2, "s": "Test" }

	match (b._index):
		0:
			assert(false, "Test assert failed.")
		1:
			var _g = b.i
			if true:
				var i = _g
				assert(i == 123, "Test assert failed.")
		2:
			var _g = b.s
			if true:
				var s = _g
				assert(false, "Test assert failed.")
	match (c._index):
		0:
			assert(false, "Test assert failed.")
		1:
			var _g = c.i
			if true:
				var i = _g
				assert(false, "Test assert failed.")
		2:
			var _g = c.s
			if true:
				var s = _g
				assert(s == "Test", "Test assert failed.")

