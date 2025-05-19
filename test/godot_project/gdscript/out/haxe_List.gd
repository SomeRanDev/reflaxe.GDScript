class_name List

var h: ListNode
var q: ListNode
var length: int

func _init() -> void:
	self.length = 0

func add(item) -> void:
	var next: ListNode = null
	var tempListNode: ListNode = ListNode.new(item, next)
	var x: ListNode = tempListNode

	if (self.h == null):
		self.h = x
	else:
		self.q.next = x

	self.q = x
	self.length += 1

func push(item) -> void:
	var next: ListNode = self.h
	var tempListNode: ListNode = ListNode.new(item, next)
	var x: ListNode = tempListNode

	self.h = x

	if (self.q == null):
		self.q = x

	self.length += 1

func first():
	var tempResult

	if (self.h == null):
		tempResult = null
	else:
		tempResult = self.h.item

	return tempResult

func pop():
	if (self.h == null):
		return null

	var x = self.h.item

	self.h = self.h.next

	if (self.h == null):
		self.q = null

	self.length -= 1

	return x

func isEmpty() -> bool:
	return self.h == null

func toString() -> String:
	var s_b: String = ""
	var first: bool = true
	var l: ListNode = self.h

	s_b += str("{")

	while (l != null):
		if (first):
			first = false
		else:
			s_b += str(", ")
		var x: String = str(l.item)
		s_b += str(x)
		l = l.next

	s_b += str("}")

	return s_b

