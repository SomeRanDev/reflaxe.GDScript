class_name TestAbstractClass

func _init() -> void:
	pass

static func test() -> void:
	var one: MyAbstractClass = MyChildOfAbstractClass.new()

	if true:
		var cond: bool = one.getInt() == 123
		assert(cond, "Test assert failed.")
	if true:
		var cond: bool = one.getBool() == false
		assert(cond, "Test assert failed.")
	if true:
		var cond: bool = one.getObject() != null
		assert(cond, "Test assert failed.")

	var one2: MyAbstractClass = MyChildOfAbstractClass2.new()

	if true:
		var cond: bool = one2.getInt() == 321
		assert(cond, "Test assert failed.")
	if true:
		var cond: bool = one2.getBool() == true
		assert(cond, "Test assert failed.")
	if true:
		var cond: bool = one2.getObject() == null
		assert(cond, "Test assert failed.")

	haxe_Log.trace.call("Test this worked??", {
		"fileName": "src/test/TestAbstractClass.hx",
		"lineNumber": 45,
		"className": "test.TestAbstractClass",
		"methodName": "test"
	})

