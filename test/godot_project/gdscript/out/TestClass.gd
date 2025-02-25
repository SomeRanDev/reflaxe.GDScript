class_name TestClass

var a: int = 2
var b: float = 3
var c: bool = false

func _init() -> void:
	if (!self.c):
		Log.trace.call(self.a, {
			"fileName": "src/test/TestClass.hx",
			"lineNumber": 10,
			"className": "test.TestClass",
			"methodName": "new",
			"customParams": ([self.b] as Array[Variant])
		})

static func test() -> void:
	Log.trace.call(TestClass.new(), {
		"fileName": "src/test/TestClass.hx",
		"lineNumber": 15,
		"className": "test.TestClass",
		"methodName": "test"
	})

