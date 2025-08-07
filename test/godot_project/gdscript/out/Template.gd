class_name haxe_Template

static var splitter: EReg = EReg.new("(::[A-Za-z0-9_ ()&|!+=/><*.\"-]+::|\\$\\$([A-Za-z0-9_-]+)\\()", "")
static var expr_splitter: EReg = EReg.new("(\\(|\\)|[ \r\n\t]*\"[^\"]*\"[ \r\n\t]*|[!+=/><*.&|-]+)", "")
static var expr_trim: EReg = EReg.new("^[ ]*([^ ]+)[ ]*$", "")
static var expr_int: EReg = EReg.new("^[0-9]+$", "")
static var expr_float: EReg = EReg.new("^([+-]?)(?=\\d|,\\d)\\d*(,\\d*)?([Ee]([+-]?\\d+))?$", "")
static var globals = {
}
static var hxKeepArrayIterator: haxe_iterators_ArrayIterator = haxe_iterators_ArrayIterator.new(([] as Array[Variant]))

var expr: Variant
var context
var macros
var stack: haxe_ds_List
var buf: StringBuf

func _init(_str: String) -> void:
	var tokens: haxe_ds_List = self.parseTokens(_str)

	self.expr = self.parseBlock(tokens)

	if (!tokens.isEmpty()):
		assert(false, str("Unexpected '" + str(tokens.first().get("s")) + "'"))

func execute(context2, macros2 = null) -> String:
	var tempRight

	if (macros2 == null):
		tempRight = {
		}
	else:
		tempRight = macros2

	self.macros = tempRight
	self.context = context2
	self.stack = haxe_ds_List.new()
	self.buf = StringBuf.new()
	self.run(self.expr)

	return self.buf.b

func resolve(v: String):
	if (v == "__current__"):
		return self.context

	var v2 = self.context
	var tempBool: bool = (v2 as Variant) is Object

	if (tempBool):
		var value = Reflect.getProperty(self.context, v)
		var tempRight
		if true:
			var o = self.context
			tempRight = v in o
		if (value != null || tempRight):
			return value

	var _this: haxe_ds_List = self.stack
	var head: haxe_ds__List_ListNode = _this.h

	while (head != null):
		var tempVar
		var val = head.item
		head = head.next
		tempVar = val
		var ctx = tempVar
		var value = Reflect.getProperty(ctx, v)
		if (value != null || v in ctx):
			return value

	var tempResult

	if true:
		var o = globals
		tempResult = o.get(v)

	return tempResult

func parseTokens(data: String) -> haxe_ds_List:
	var tokens: haxe_ds_List = haxe_ds_List.new()

	while (splitter._match(data)):
		var p: Variant = splitter.matchedPos()
		if (p.get("pos") > 0):
			tokens.add({
				"p": data.substr(0, p.get("pos")),
				"s": true,
				"l": null
			})
		var tempLeft
		var index: int = p.get("pos")
		if (index >= 0 && index < data.length()):
			tempLeft = data.unicode_at(index)
		else:
			tempLeft = null
		if (tempLeft == 58):
			tokens.add({
				"p": data.substr(p.get("pos") + 2, p.get("len") - 4),
				"s": false,
				"l": null
			})
			data = splitter.matchedRight()
			continue
		var parp: int = p.get("pos") + p.get("len")
		var npar: int = 1
		var params: Array[String] = ([] as Array[String])
		var part: String = ""
		while (true):
			var tempMaybeNumber
			if (parp >= 0 && parp < data.length()):
				tempMaybeNumber = data.unicode_at(parp)
			else:
				tempMaybeNumber = null
			var c = tempMaybeNumber
			parp += 1
			if (c == 40):
				npar += 1
			else:
				if (c == 41):
					npar -= 1
					if (npar <= 0):
						break
				else:
					if (c == null):
						assert(false, str("Unclosed macro parenthesis"))
			if (c == 44 && npar == 1):
				params.push_back(part)
				part = ""
			else:
				part += char(c)
		params.push_back(part)
		tokens.add({
			"p": splitter.matched(2),
			"s": false,
			"l": params
		})
		data = data.substr(parp, data.length() - parp)

	if (data.length() > 0):
		tokens.add({
			"p": data,
			"s": true,
			"l": null
		})

	return tokens

func parseBlock(tokens: haxe_ds_List) -> Variant:
	var l: haxe_ds_List = haxe_ds_List.new()

	while (true):
		var t = tokens.first()
		if (t == null):
			break
		if (!t.get("s") && (t.get("p") == "end" || t.get("p") == "else" || t.get("p").substr(0, 7) == "elseif ")):
			break
		l.add(self.parse(tokens))

	if (l.length == 1):
		return l.first()

	return { "_index": 4, "l": l }

func parse(tokens: haxe_ds_List) -> Variant:
	var t = tokens.pop()
	var p: String = t.get("p")

	if (t.get("s")):
		return { "_index": 3, "str": p }
	if (t.get("l") != null):
		var pe: haxe_ds_List = haxe_ds_List.new()
		var _g: int = 0
		var _g1: Array[String] = t.get("l")
		while (_g < _g1.size()):
			var p2: String = _g1[_g]
			_g += 1
			pe.add(self.parseBlock(self.parseTokens(p2)))
		return { "_index": 6, "name": p, "params": pe }

	var kwdEnd = func(kwd: String) -> int:
		var pos: int = -1
		var length: int = kwd.length()
		if (p.substr(0, length) == kwd):
			pos = length
			var _g_s
			var _g_offset
			var s: String = p.substr(length)
			_g_offset = 0
			_g_s = s
			while (_g_offset < _g_s.length()):
				var tempNumber
				var s2: String = _g_s
				var tempNumber1
				_g_offset += 1
				tempNumber1 = _g_offset - 1
				var index: int = tempNumber1
				tempNumber = s2.unicode_at.call(index)
				var c: int = tempNumber
				if (c == 32):
					pos += 1
				else:
					break
		return pos
	var pos: int = kwdEnd.call("if")

	if (pos > 0):
		p = p.substr(pos, p.length() - pos)
		var e = self.parseExpr(p)
		var eif: Variant = self.parseBlock(tokens)
		var t2 = tokens.first()
		var eelse
		if (t2 == null):
			assert(false, str("Unclosed 'if'"))
		if (t2.get("p") == "end"):
			tokens.pop()
			eelse = null
		else:
			if (t2.get("p") == "else"):
				tokens.pop()
				eelse = self.parseBlock(tokens)
				t2 = tokens.pop()
				if (t2 == null || t2.get("p") != "end"):
					assert(false, str("Unclosed 'else'"))
			else:
				t2.set("p", t2.get("p").substr(4, t2.get("p").length() - 4))
				eelse = self.parse(tokens)
		return { "_index": 2, "expr": e, "eif": eif, "eelse": eelse }

	var pos2: int = kwdEnd.call("foreach")

	if (pos2 >= 0):
		p = p.substr(pos2, p.length() - pos2)
		var e = self.parseExpr(p)
		var efor: Variant = self.parseBlock(tokens)
		var t2 = tokens.pop()
		if (t2 == null || t2.get("p") != "end"):
			assert(false, str("Unclosed 'foreach'"))
		return { "_index": 5, "expr": e, "loop": efor }
	if (expr_splitter._match(p)):
		return { "_index": 1, "expr": self.parseExpr(p) }

	return { "_index": 0, "v": p }

func parseExpr(data: String):
	var l: haxe_ds_List = haxe_ds_List.new()
	var expr2: String = data

	while (expr_splitter._match(data)):
		var p: Variant = expr_splitter.matchedPos()
		var k: int = p.get("pos") + p.get("len")
		if (p.get("pos") != 0):
			l.add({
				"p": data.substr(0, p.get("pos")),
				"s": true
			})
		var p2: String = expr_splitter.matched(0)
		l.add({
			"p": p2,
			"s": p2.find("\"") >= 0
		})
		data = expr_splitter.matchedRight()

	if (data.length() != 0):
		var _g_s
		var _g_offset
		_g_offset = 0
		_g_s = data
		while (_g_offset < _g_s.length()):
			var _g_value
			var _g_key
			_g_key = _g_offset
			var tempRight
			if true:
				var s: String = _g_s
				var tempNumber
				if true:
					_g_offset += 1
					tempNumber = _g_offset - 1
				var index: int = tempNumber
				tempRight = s.unicode_at.call(index)
			_g_value = tempRight
			var i: int = _g_key
			var c: int = _g_value
			if (c == 32):
				pass
			else:
				l.add({
					"p": data.substr(i),
					"s": true
				})
				break

	var e

	if true:
		e = self.makeExpr(l)
		if (!l.isEmpty()):
			assert(false, str(l.first().get("p")))

	return func():
		return e.call()

func makeConst(v: String):
	expr_trim._match(v)
	v = expr_trim.matched(1)

	var tempMaybeNumber

	if (0 >= 0 && 0 < v.length()):
		tempMaybeNumber = v.unicode_at(0)
	else:
		tempMaybeNumber = null
	if ((tempMaybeNumber) == 34):
		var _str: String = v.substr(1, v.length() - 2)
		return func() -> String:
			return _str
	if (expr_int._match(v)):
		var i = v.to_int()
		return func():
			return i
	if (expr_float._match(v)):
		var f = [v.to_float()]
		return func() -> float:
			return f[0]

	var me: haxe_Template = self

	return func():
		return me.resolve(v)

func makePath(e, l: haxe_ds_List):
	var p = l.first()

	if (p == null || p.get("p") != "."):
		return e

	l.pop()

	var field = l.pop()

	if (field == null || !field.get("s")):
		assert(false, str(field.get("p")))

	var f: String = field.get("p")

	expr_trim._match(f)
	f = expr_trim.matched(1)

	return self.makePath(func():
		var tempResult
		var o = e.call()
		tempResult = o.get(f)
		return tempResult, l)

func makeExpr(l: haxe_ds_List):
	return self.makePath(self.makeExpr2(l), l)

func skipSpaces(l: haxe_ds_List) -> void:
	var p = l.first()

	while (p != null):
		var _g_s
		var _g_offset
		var s: String = p.get("p")
		_g_offset = 0
		_g_s = s
		while (_g_offset < _g_s.length()):
			var tempNumber
			var s2: String = _g_s
			var tempNumber1
			_g_offset += 1
			tempNumber1 = _g_offset - 1
			var index: int = tempNumber1
			tempNumber = s2.unicode_at.call(index)
			var c: int = tempNumber
			if (c != 32):
				return
		l.pop()
		p = l.first()

func makeExpr2(l: haxe_ds_List):
	self.skipSpaces(l)

	var p = l.pop()

	self.skipSpaces(l)

	if (p == null):
		assert(false, str("<eof>"))
	if (p.get("s")):
		return self.makeConst(p.get("p"))

	if true:
		var _g: String = p.get("p")
		match (_g):
			"!":
				var e = self.makeExpr(l)
				return func() -> bool:
					var v = e.call()
					return v == null || v == false
			"(":
				self.skipSpaces(l)
				var e1 = self.makeExpr(l)
				self.skipSpaces(l)
				var p2 = l.pop()
				if (p2 == null || p2.get("s")):
					assert(false, str(p2))
				if (p2.get("p") == ")"):
					return e1
				self.skipSpaces(l)
				var e2 = self.makeExpr(l)
				self.skipSpaces(l)
				var p3 = l.pop()
				self.skipSpaces(l)
				if (p3 == null || p3.get("p") != ")"):
					assert(false, str(p3))
				var tempResult
				if true:
					var _g2: String = p2.get("p")
					match (_g2):
						"!=":
							tempResult = func():
								return e1.call() != e2.call()
						"&&":
							tempResult = func():
								return e1.call() && e2.call()
						"*":
							tempResult = func():
								return e1.call() * e2.call()
						"+":
							tempResult = func():
								return e1.call() + e2.call()
						"-":
							tempResult = func():
								return e1.call() - e2.call()
						"/":
							tempResult = func():
								return e1.call() / e2.call()
						"<":
							tempResult = func():
								return e1.call() < e2.call()
						"<=":
							tempResult = func():
								return e1.call() <= e2.call()
						"==":
							tempResult = func():
								return e1.call() == e2.call()
						">":
							tempResult = func():
								return e1.call() > e2.call()
						">=":
							tempResult = func():
								return e1.call() >= e2.call()
						"||":
							tempResult = func():
								return e1.call() || e2.call()
						_:
							assert(false, str("Unknown operation " + p2.get("p")))
				return tempResult
			"-":
				var e = self.makeExpr(l)
				return func() -> float:
					return -e.call()

	assert(false, str(p.get("p")))

func run(e: Variant) -> void:
	match (e._index):
		0:
			var _g: String = e.v
			if true:
				var v: String = _g
				if true:
					var _this: StringBuf = self.buf
					var x: String = str(self.resolve(v))
					_this.b += str(x)
		1:
			var _g = e.expr
			if true:
				var e2 = _g
				if true:
					var _this: StringBuf = self.buf
					var x: String = str(e2.call())
					_this.b += str(x)
		2:
			var _g = e.expr
			var _g1: Variant = e.eif
			var _g2: Variant = e.eelse
			if true:
				var e2 = _g
				var eif: Variant = _g1
				var eelse: Variant = _g2
				if true:
					var v = e2.call()
					if (v == null || v == false):
						if (eelse != null):
							self.run(eelse)
					else:
						self.run(eif)
		3:
			var _g: String = e.str
			var _str: String = _g
			if true:
				var _this: StringBuf = self.buf
				_this.b += str(_str)
		4:
			var _g: haxe_ds_List = e.l
			var l: haxe_ds_List = _g
			if true:
				var _g_head
				var head: haxe_ds__List_ListNode = l.h
				_g_head = head
				while (_g_head != null):
					var tempTemplateExpr
					if true:
						var val: Variant = _g_head.item
						_g_head = _g_head.next
						tempTemplateExpr = val
					var e2: Variant = tempTemplateExpr
					self.run(e2)
		5:
			var _g = e.expr
			var _g1: Variant = e.loop
			if true:
				var e2 = _g
				var loop: Variant = _g1
				if true:
					var v = e2.call()
					if true:
						var x = v.iterator.call()
						if (x.hasNext == null):
							assert(false, str(null))
						v = x
					self.stack.push(self.context)
					var v2: Variant = v
					if true:
						var ctx: Variant = v2
						while (ctx.get("hasNext").call()):
							var ctx2 = ctx.get("next").call()
							self.context = ctx2
							self.run(loop)
					self.context = self.stack.pop()
		6:
			var _g: String = e.name
			var _g1: haxe_ds_List = e.params
			var m: String = _g
			var params: haxe_ds_List = _g1
			if true:
				var tempVar
				if true:
					var o = self.macros
					tempVar = o.get(m)
				var v = tempVar
				var pl: Array[Variant] = []
				var old: StringBuf = self.buf
				pl.push_back(self.resolve)
				if true:
					var _g_head
					var head: haxe_ds__List_ListNode = params.h
					_g_head = head
					while (_g_head != null):
						var tempTemplateExpr1
						if true:
							var val: Variant = _g_head.item
							_g_head = _g_head.next
							tempTemplateExpr1 = val
						var p: Variant = tempTemplateExpr1
						if (p._index == 0):
							var _g2: String = p.v
							if true:
								var v2: String = _g2
								pl.push_back(self.resolve(v2))
						else:
							self.buf = StringBuf.new()
							self.run(p)
							pl.push_back(self.buf.b)
				self.buf = old
				if true:
					var _this: StringBuf = self.buf
					var tempVar1
					if true:
						var o = self.macros
						tempVar1 = v.callv(pl)
					var x: String = str(tempVar1)
					_this.b += str(x)
