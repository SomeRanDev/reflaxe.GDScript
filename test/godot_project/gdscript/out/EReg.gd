class_name EReg

var regObj

var regexStr

var m

func _init(r, opt):
	self.m = null
	self.regObj = RegEx.new()
	self.regexStr = r

func reset():
	self.regObj.clear.call()
	self.regObj.compile.call(self.regexStr)

func match(s):
	self.reset()
	self.m = self.regObj.search.call(s)

	return !(!self.m)

func matched(n):
	if (self.m != null):
		return self.m.get_string.call(n)

	return ""

func matchedLeft():
	assert(false, "EReg.matchedLeft not implemented for GDScript.")

func matchedRight():
	assert(false, "EReg.matchedRight not implemented for GDScript.")

func matchedPos():
	if (self.m == null):
		return {
			"pos": -1,
			"len": -1
		}

	return {
		"pos": self.m.get_start.call(),
		"len": self.m.get_end.call() - self.m.get_start.call()
	}

func matchSub(s, pos, len = -1):
	self.reset()

	var tempNumber

	if (len == -1):
		tempNumber = -1
	else:
		tempNumber = s.length() - pos + len

	self.m = self.regObj.search.call(s, pos, tempNumber)

	return !(!self.m)

func split(s):
	if (s == null || s.length() <= 0):
		return [s]

	var result = []
	var index = 0

	while ((true)):
		if (self.matchSub(s, index)):
			var pos = self.matchedPos()
			var tempString
			if true:
				var endIndex = pos.get("pos")
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
				var endIndex = -1
				if (endIndex < 0):
					tempString1 = s.substr(index)
				else:
					tempString1 = s.substr(index, endIndex - index)
			result.push_back(tempString1)
			break

	return result

func replace(s, by):
	return self.regObj.sub.call(s, by)

func map(s, f):
	assert(false, "EReg.map not implemented for GDScript.")

static func escape(s):
	assert(false, "EReg.escape not implemented for GDScript.")

