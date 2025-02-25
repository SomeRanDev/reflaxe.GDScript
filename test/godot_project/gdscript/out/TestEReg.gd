class_name TestEReg

func _init() -> void:
	pass

static func test() -> void:
	var reg: EReg = EReg.new("abc", "")

	if true:
		var cond: bool = reg._match("abcdef")
		assert(cond, "Test assert failed.")
	if true:
		var cond: bool = reg.matched(0) == "abc"
		assert(cond, "Test assert failed.")

	var pos: Dictionary = reg.matchedPos()

	if true:
		var cond: bool = pos.get("pos") == 0
		assert(cond, "Test assert failed.")
	if true:
		var cond: bool = pos.get("len") == 3
		assert(cond, "Test assert failed.")
	if true:
		var cond: bool = EReg.new("abc", "").matchSub("abcabc", 1, -1)
		assert(cond, "Test assert failed.")
	if true:
		var cond: bool = EReg.new("\\s*,\\s*", "").split("one,two ,three, four") == (["one", "two", "three", "four"] as Array[String])
		assert(cond, "Test assert failed.")
	if true:
		var cond: bool = reg.replace("123abc", "456") == "123456"
		assert(cond, "Test assert failed.")

