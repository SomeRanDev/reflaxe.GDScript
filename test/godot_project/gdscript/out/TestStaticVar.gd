class_name TestStaticVar

static var count: int = 0

func _init() -> void:
	TestStaticVar.count += 1

static func test() -> void:
	TestStaticVar.count = 10

	if true:
		var cond: bool = TestStaticVar.count == 10
		assert(cond, "Test assert failed.")

	var list: Array = []

	list.push_back(TestStaticVar.new())
	list.push_back(TestStaticVar.new())
	list.push_back(TestStaticVar.new())
	list.push_back(TestStaticVar.new())
	list.push_back(TestStaticVar.new())
	list.push_back(TestStaticVar.new())
	list.push_back(TestStaticVar.new())
	list.push_back(TestStaticVar.new())
	list.push_back(TestStaticVar.new())
	list.push_back(TestStaticVar.new())

	if true:
		var cond: bool = TestStaticVar.count == 20
		assert(cond, "Test assert failed.")
	if true:
		var cond: bool = OtherClass.str.length() == 0
		assert(cond, "Test assert failed.")

	OtherClass.add.call()
	OtherClass.add.call()
	OtherClass.add.call()

	if true:
		var cond: bool = OtherClass.str.length() == 3
		assert(cond, "Test assert failed.")

	OtherClass.clear()

	if true:
		var cond: bool = OtherClass.str.length() == 0
		assert(cond, "Test assert failed.")

	var old = OtherClass.add

	OtherClass.add = func():
		old.call()
		old.call()
	OtherClass.add.call()

	if true:
		var cond: bool = OtherClass.str == "||"
		assert(cond, "Test assert failed.")

	if (OtherClass.add != null):
		assert(true, "Test assert failed.")
	else:
		assert(false, "Test assert failed.")

