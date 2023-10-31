class_name TestEReg

func _init():
	pass

static func test():
	var reg = EReg.new("abc", "")

	if true:
		var cond = reg.match("abcdef")
		assert(cond, "Test assert failed.")
	if true:
		var cond = reg.matched(0) == "abc"
		assert(cond, "Test assert failed.")

	var pos = reg.matchedPos()

	if true:
		var cond = pos.get("pos") == 0
		assert(cond, "Test assert failed.")
	if true:
		var cond = pos.get("len") == 3
		assert(cond, "Test assert failed.")
	if true:
		var cond = EReg.new("abc", "").matchSub("abcabc", 1)
		assert(cond, "Test assert failed.")
	if true:
		var cond = EReg.new("\\s*,\\s*", "").split("one,two ,three, four") == ["one", "two", "three", "four"]
		assert(cond, "Test assert failed.")
	if true:
		var cond = reg.replace("123abc", "456") == "123456"
		assert(cond, "Test assert failed.")

