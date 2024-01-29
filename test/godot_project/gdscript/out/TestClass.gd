class_name TestClass

var a: int
var b: float
var c: bool

func _init() -> void:
	self.c = false
	self.b = 3
	self.a = 2

	if (!self.c):
		Log.trace.call(self.a, {
			"fileName": "src/test/TestClass.hx",
			"lineNumber": 10,
			"className": "test.TestClass",
			"methodName": "new",
			"customParams": [self.b]
		})

static func test() -> void:
	Log.trace.call(TestClass.new(), {
		"fileName": "src/test/TestClass.hx",
		"lineNumber": 15,
		"className": "test.TestClass",
		"methodName": "test"
	})

