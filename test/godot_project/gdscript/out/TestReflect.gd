class_name TestReflect

func _init():
	pass

static func test():
	var obj = {
		"num": 123,
		"str": "String"
	}
	var cls = MyClass.new()

	if true:
		var cond = "num" in obj
		assert(cond, "Test assert failed.")
	if true:
		var cond = !"dog" in obj
		assert(cond, "Test assert failed.")
	if true:
		var cond = obj.get("str") == "String"
		assert(cond, "Test assert failed.")

	Reflect.setField(obj, "num", 444)

	if true:
		var cond = obj.get("num") == 444
		assert(cond, "Test assert failed.")
	if true:
		var cond = Reflect.getProperty(cls, "myProp") == 1
		assert(cond, "Test assert failed.")

	Reflect.setProperty(cls, "myProp", 10)

	if true:
		var cond = Reflect.getProperty(cls, "myProp") == 10
		assert(cond, "Test assert failed.")

	var _func = func(a):
		return a + 123

	if true:
		var cond = _func.callv([100]) == 223
		assert(cond, "Test assert failed.")
	if true:
		var cond = Reflect.fields(cls).size() == 4
		assert(cond, "Test assert failed.")
	if true:
		var cond = !obj is Callable
		assert(cond, "Test assert failed.")
	if true:
		var cond = _func is Callable
		assert(cond, "Test assert failed.")
	if true:
		var cond = Reflect.compare(12, 14) == -1
		assert(cond, "Test assert failed.")

	assert(_func == _func, "Test assert failed.")

	if true:
		var cond = !obj is Object
		assert(cond, "Test assert failed.")
	if true:
		var cond = obj is Dictionary
		assert(cond, "Test assert failed.")

	var obj2 = Reflect.copy(obj)

	if true:
		var cond = obj2.get("str") == obj.get("str")
		assert(cond, "Test assert failed.")

	Reflect.deleteField(obj, "num")

	if true:
		var cond = obj.get("num") == null
		assert(cond, "Test assert failed.")

