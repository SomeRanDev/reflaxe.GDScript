class_name TestMap

func _init() -> void:
	pass

static func test() -> void:
	var m: StringMap = StringMap.new()
	var _g: IntMap = IntMap.new()

	_g.__set(123, "123")
	_g.__set(321, "321")
	m.__set("a", 1)
	m.__set("b", 2)

	var tempNumber: int = 2

	tempNumber

	if true:
		var cond: bool = m.__get("a") == 1
		assert(cond, "Test assert failed.")
	if true:
		var cond: bool = m.__get("b") == 2
		assert(cond, "Test assert failed.")
	if true:
		var cond: bool = _g.__get(321) == "321"
		assert(cond, "Test assert failed.")

	var m3: StringMap = m.copy()

	if true:
		var cond: bool = m3.__get("a") == 1
		assert(cond, "Test assert failed.")
	if true:
		var cond: bool = m3.__get("b") == 2
		assert(cond, "Test assert failed.")

	m3.clear()

	if true:
		var cond: bool = !m3.exists("a")
		assert(cond, "Test assert failed.")
	if true:
		var cond: bool = m.exists("a")
		assert(cond, "Test assert failed.")
	if true:
		var cond: bool = !m.exists("c")
		assert(cond, "Test assert failed.")
	if true:
		var cond: bool = _g.exists(123)
		assert(cond, "Test assert failed.")
	if true:
		var cond: bool = !_g.exists(124)
		assert(cond, "Test assert failed.")

	m.remove("a")

	if true:
		var cond: bool = !m.exists("a")
		assert(cond, "Test assert failed.")

	Log.trace.call(m.toString(), {
		"fileName": "src/test/TestMap.hx",
		"lineNumber": 40,
		"className": "test.TestMap",
		"methodName": "test"
	})
