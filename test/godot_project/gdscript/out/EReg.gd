class_name EReg

var regObj

var regexStr: String

var m

func _init(r: String, opt: String) -> void:
	self.m = null
	self.regObj = RegEx.new()
	self.regexStr = r

func reset() -> void:
	self.regObj.clear.call()
	self.regObj.compile.call(self.regexStr)

func _match(s: String) -> bool:
	self.reset()
	self.m = self.regObj.search.call(s)

	return !(!self.m)

func matched(n: int) -> String:
	if (self.m != null):
		return self.m.get_string.call(n)

	return ""

func matchedLeft() -> String:
	assert(false, "EReg.matchedLeft not implemented for GDScript.")

	return ""

func matchedRight() -> String:
	assert(false, "EReg.matchedRight not implemented for GDScript.")

	return ""

func matchedPos() -> Dictionary:
	if (self.m == null):
		return {
			"pos": -1,
			"len": -1
		}

	return {
		"pos": self.m.get_start.call(),
		"len": self.m.get_end.call() - self.m.get_start.call()
	}

func matchSub(s: String, pos: int, len: int = -1) -> bool:
	self.reset()

	var tempNumber

	if (len == -1):
		tempNumber = -1
	else:
		tempNumber = s.length() - pos + len

	self.m = self.regObj.search.call(s, pos, tempNumber)

	return !(!self.m)

func split(s: String) -> Array:
	if (s == null || s.length() <= 0):
		return [s]

	var result: Array = []
	var index: int = 0

	while ((true)):
		if (self.matchSub(s, index, -1)):
			var pos: Dictionary = self.matchedPos()
			var tempString
			if true:
				var endIndex: int = pos.get("pos")
				if (endIndex < 0):
					tempString = s.substr(index)
				else:
					tempString = s.substr(index, endIndex - index)
			result.push_back(tempString)
			if (pos.get("pos") + pos.get("len") <= index):
				break
			index = pos.get("pos") + pos.get("len")
			if (index >= s.length()):
				break
		else:
			var tempString1
			if true:
				var endIndex: int = -1
				if (endIndex < 0):
					tempString1 = s.substr(index)
				else:
					tempString1 = s.substr(index, endIndex - index)
			result.push_back(tempString1)
			break

	return result

func replace(s: String, by: String) -> String:
	return self.regObj.sub.call(s, by)

func map(s: String, f) -> String:
	assert(false, "EReg.map not implemented for GDScript.")

	return ""

static func escape(s: String) -> String:
	assert(false, "EReg.escape not implemented for GDScript.")

	return ""

