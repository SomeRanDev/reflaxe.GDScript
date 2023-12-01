class_name TestStaticVar

func _init() -> void:
	HxStaticVars._TestStaticVar.count += 1

static func test() -> void:
	HxStaticVars._TestStaticVar.count = 10

	if true:
		var cond: bool = HxStaticVars._TestStaticVar.count == 10
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
		var cond: bool = HxStaticVars._TestStaticVar.count == 20
		assert(cond, "Test assert failed.")
	if true:
		var cond: bool = HxStaticVars._OtherClass.str.length() == 0
		assert(cond, "Test assert failed.")

	HxStaticVars._OtherClass.add.call()
	HxStaticVars._OtherClass.add.call()
	HxStaticVars._OtherClass.add.call()

	if true:
		var cond: bool = HxStaticVars._OtherClass.str.length() == 3
		assert(cond, "Test assert failed.")

	OtherClass.clear()

	if true:
		var cond: bool = HxStaticVars._OtherClass.str.length() == 0
		assert(cond, "Test assert failed.")

	var old = HxStaticVars._OtherClass.add

	HxStaticVars._OtherClass.add = func():
		old.call()
		old.call()
	HxStaticVars._OtherClass.add.call()

	if true:
		var cond: bool = HxStaticVars._OtherClass.str == "||"
		assert(cond, "Test assert failed.")

	if (HxStaticVars._OtherClass.add != null):
		assert(true, "Test assert failed.")
	else:
		assert(false, "Test assert failed.")

