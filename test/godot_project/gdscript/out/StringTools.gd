class_name StringTools

static var winMetaCharacters: Array[int] = haxe_SysTools.winMetaCharacters

func _init() -> void:
	pass

static func urlEncode(s: String) -> String:
	return ""

static func urlDecode(s: String) -> String:
	return null

static func htmlEscape(s: String, quotes: bool = false) -> String:
	var buf_b: String = ""
	var _g_offset: int = 0
	var _g_s: String = s

	while (_g_offset < _g_s.length()):
		var tempNumber
		if true:
			var tempNumber1
			if true:
				var s2: String = _g_s
				var tempNumber2
				if true:
					_g_offset += 1
					tempNumber2 = _g_offset - 1
				var index: int = tempNumber2
				var c: int = s2.unicode_at.call(index)
				if (c >= 55296 && c <= 56319):
					c = c - 55232 << 10 | s2.unicode_at.call(index + 1) & 1023
				tempNumber1 = c
			var c: int = tempNumber1
			if (c >= 65536):
				_g_offset += 1
			tempNumber = c
		var code: int = tempNumber
		match (code):
			34:
				if (quotes):
					buf_b += str("&quot;")
				else:
					buf_b += char(code)
			38:
				buf_b += str("&amp;")
			39:
				if (quotes):
					buf_b += str("&#039;")
				else:
					buf_b += char(code)
			60:
				buf_b += str("&lt;")
			62:
				buf_b += str("&gt;")
			_:
				buf_b += char(code)

	return buf_b

static func htmlUnescape(s: String) -> String:
	var tempResult

	if true:
		var tempArray
		if true:
			var tempString
			if true:
				var tempArray1
				if true:
					var tempString1
					if true:
						var tempArray2
						if true:
							var tempString2
							if true:
								var tempArray3
								if true:
									var tempString3
									if true:
										var _this: Array[String] = Array(Array(s.split("&gt;")), Variant.Type.TYPE_STRING, "", null)
										var result: String = ""
										var len: int = _this.size()
										if true:
											var _g: int = 0
											var _g1: int = len
											while (_g < _g1):
												var tempNumber
												if true:
													_g += 1
													tempNumber = _g - 1
												var i: int = tempNumber
												var tempString4
												if (i == len - 1):
													tempString4 = ""
												else:
													tempString4 = ">"
												result += str(_this[i]) + (tempString4)
										tempString3 = result
									var _this: String = tempString3
									tempArray3 = Array(Array(_this.split("&lt;")), Variant.Type.TYPE_STRING, "", null)
								var result: String = ""
								var len: int = tempArray3.size()
								if true:
									var _g: int = 0
									var _g1: int = len
									while (_g < _g1):
										var tempNumber1
										if true:
											_g += 1
											tempNumber1 = _g - 1
										var i: int = tempNumber1
										var tempString5
										if (i == len - 1):
											tempString5 = ""
										else:
											tempString5 = "<"
										result += str(tempArray3[i]) + (tempString5)
								tempString2 = result
							var _this: String = tempString2
							tempArray2 = Array(Array(_this.split("&quot;")), Variant.Type.TYPE_STRING, "", null)
						var result: String = ""
						var len: int = tempArray2.size()
						if true:
							var _g: int = 0
							var _g1: int = len
							while (_g < _g1):
								var tempNumber2
								if true:
									_g += 1
									tempNumber2 = _g - 1
								var i: int = tempNumber2
								var tempString6
								if (i == len - 1):
									tempString6 = ""
								else:
									tempString6 = "\""
								result += str(tempArray2[i]) + (tempString6)
						tempString1 = result
					var _this: String = tempString1
					tempArray1 = Array(Array(_this.split("&#039;")), Variant.Type.TYPE_STRING, "", null)
				var result: String = ""
				var len: int = tempArray1.size()
				if true:
					var _g: int = 0
					var _g1: int = len
					while (_g < _g1):
						var tempNumber3
						if true:
							_g += 1
							tempNumber3 = _g - 1
						var i: int = tempNumber3
						var tempString7
						if (i == len - 1):
							tempString7 = ""
						else:
							tempString7 = "'"
						result += str(tempArray1[i]) + (tempString7)
				tempString = result
			var _this: String = tempString
			tempArray = Array(Array(_this.split("&amp;")), Variant.Type.TYPE_STRING, "", null)
		var result: String = ""
		var len: int = tempArray.size()
		if true:
			var _g: int = 0
			var _g1: int = len
			while (_g < _g1):
				var tempNumber4
				if true:
					_g += 1
					tempNumber4 = _g - 1
				var i: int = tempNumber4
				var tempString8
				if (i == len - 1):
					tempString8 = ""
				else:
					tempString8 = "&"
				result += str(tempArray[i]) + (tempString8)
		tempResult = result

	return tempResult

static func contains(s: String, value: String) -> bool:
	return s.find(value) != -1

static func startsWith(s: String, start: String) -> bool:
	var tempNumber

	if (0 < 0):
		tempNumber = s.rfind(start)
	else:
		var tempString
		var endIndex: int = 0 + s.length()
		if (endIndex < 0):
			tempString = s.substr(0)
		else:
			tempString = s.substr(0, endIndex - 0)
		tempNumber = (tempString).rfind(start)

	return s.length() >= start.length() && (tempNumber) == 0

static func endsWith(s: String, end: String) -> bool:
	var elen: int = end.length()
	var slen: int = s.length()

	return slen >= elen && s.find(end, slen - elen) == slen - elen

static func isSpace(s: String, pos: int) -> bool:
	var tempMaybeNumber

	if (pos >= 0 && pos < s.length()):
		tempMaybeNumber = s.unicode_at(pos)
	else:
		tempMaybeNumber = null

	var c = tempMaybeNumber

	return c > 8 && c < 14 || c == 32

static func ltrim(s: String) -> String:
	var l: int = s.length()
	var r: int = 0

	while (r < l && StringTools.isSpace(s, r)):
		r += 1

	if (r > 0):
		return s.substr(r, l - r)
	else:
		return s

static func rtrim(s: String) -> String:
	var l: int = s.length()
	var r: int = 0

	while (r < l && StringTools.isSpace(s, l - r - 1)):
		r += 1

	if (r > 0):
		return s.substr(0, l - r)
	else:
		return s

static func trim(s: String) -> String:
	var tempResult

	if true:
		var tempString
		if true:
			var l: int = s.length()
			var r: int = 0
			while (r < l && StringTools.isSpace(s, l - r - 1)):
				r += 1
			if (r > 0):
				tempString = s.substr(0, l - r)
			else:
				tempString = s
		var s2: String = tempString
		var l: int = s2.length()
		var r: int = 0
		while (r < l && StringTools.isSpace(s2, r)):
			r += 1
		if (r > 0):
			tempResult = s2.substr(r, l - r)
		else:
			tempResult = s2

	return tempResult

static func lpad(s: String, c: String, l: int) -> String:
	if (c.length() <= 0):
		return s

	var buf_b: String = ""

	l -= s.length()

	while (buf_b.length() < l):
		buf_b += str(c)

	buf_b += str(s)

	return buf_b

static func rpad(s: String, c: String, l: int) -> String:
	if (c.length() <= 0):
		return s

	var buf_b: String = ""

	buf_b += str(s)

	while (buf_b.length() < l):
		buf_b += str(c)

	return buf_b

static func replace(s: String, sub: String, by: String) -> String:
	var _this: Array[String] = Array(Array(s.split(sub)), Variant.Type.TYPE_STRING, "", null)
	var result: String = ""
	var len: int = _this.size()
	var _g: int = 0
	var _g1: int = len

	while (_g < _g1):
		var tempNumber
		_g += 1
		tempNumber = _g - 1
		var i: int = tempNumber
		var tempString
		if (i == len - 1):
			tempString = ""
		else:
			tempString = by
		result += str(_this[i]) + (tempString)

	var tempResult: String = result

	return tempResult

static func hex(n: int, digits = null) -> String:
	var s: String = ""
	var hexChars: String = "0123456789ABCDEF"

	while true:
		s = hexChars[n & 15] + s
		n >>>= 4	if (n > 0):
			break

	if (digits != null):
		while (s.length() < digits):
			s = "0" + s

	return s

static func fastCodeAt(s: String, index: int) -> int:
	return s.unicode_at.call(index)

static func unsafeCodeAt(s: String, index: int) -> int:
	return s.unicode_at.call(index)

static func iterator(s: String) -> haxe_iterators_StringIterator:
	return haxe_iterators_StringIterator.new(s)

static func keyValueIterator(s: String) -> haxe_iterators_StringKeyValueIterator:
	return haxe_iterators_StringKeyValueIterator.new(s)

static func isEof(c: int) -> bool:
	return false

static func quoteUnixArg(argument: String) -> String:
	var tempResult

	if (argument == ""):
		tempResult = "''"
	else:
		if (!EReg.new("[^a-zA-Z0-9_@%+=:,./-]", "")._match(argument)):
			tempResult = argument
		else:
			tempResult = "'" + StringTools.replace(argument, "'", "'\"'\"'") + "'"

	return tempResult

static func quoteWinArg(argument: String, escapeMetaCharacters: bool) -> String:
	var tempResult
	var argument2: String = argument

	if (!EReg.new("^(/)?[^ \t/\\\\\"]+$", "")._match(argument2)):
		var result_b
		result_b = ""
		var needquote: bool = argument2.find(" ") != -1 || argument2.find("\t") != -1 || argument2 == "" || argument2.find("/") > 0
		if (needquote):
			result_b += str("\"")
		var bs_buf: StringBuf = StringBuf.new()
		if true:
			var _g: int = 0
			var _g1: int = argument2.length()
			while (_g < _g1):
				var tempNumber
				if true:
					_g += 1
					tempNumber = _g - 1
				var i: int = tempNumber
				if true:
					var tempMaybeNumber
					if (i >= 0 && i < argument2.length()):
						tempMaybeNumber = argument2.unicode_at(i)
					else:
						tempMaybeNumber = null
					var _g2 = tempMaybeNumber
					if (_g2 == null):
						var c = _g2
						if true:
							if (bs_buf.b.length() > 0):
								if true:
									var x: String = bs_buf.b
									result_b += str(x)
								bs_buf = StringBuf.new()
							if true:
								var c2: int = c
								result_b += char(c2)
					else:
						match (_g2):
							34:
								var bs: String = bs_buf.b
								result_b += str(bs)
								result_b += str(bs)
								bs_buf = StringBuf.new()
								result_b += str("\\\"")
							92:
								bs_buf.b += str("\\")
							_:
								var c = _g2
								if true:
									if (bs_buf.b.length() > 0):
										if true:
											var x: String = bs_buf.b
											result_b += str(x)
										bs_buf = StringBuf.new()
									if true:
										var c2: int = c
										result_b += char(c2)
		if true:
			var x: String = bs_buf.b
			result_b += str(x)
		if (needquote):
			if true:
				var x: String = bs_buf.b
				result_b += str(x)
			result_b += str("\"")
		argument2 = result_b
	if (escapeMetaCharacters):
		var result_b
		result_b = ""
		if true:
			var _g: int = 0
			var _g1: int = argument2.length()
			while (_g < _g1):
				var tempNumber1
				if true:
					_g += 1
					tempNumber1 = _g - 1
				var i: int = tempNumber1
				var tempMaybeNumber1
				if (i >= 0 && i < argument2.length()):
					tempMaybeNumber1 = argument2.unicode_at(i)
				else:
					tempMaybeNumber1 = null
				var c = tempMaybeNumber1
				if (haxe_SysTools.winMetaCharacters.find(c) >= 0):
					result_b += char(94)
				if true:
					var c2: int = c
					result_b += char(c2)
		tempResult = result_b
	else:
		tempResult = argument2

	return tempResult

static func utf16CodePointAt(s: String, index: int) -> int:
	var c: int = s.unicode_at.call(index)

	if (c >= 55296 && c <= 56319):
		c = c - 55232 << 10 | s.unicode_at.call(index + 1) & 1023

	return c

