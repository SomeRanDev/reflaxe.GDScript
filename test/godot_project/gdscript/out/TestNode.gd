extends Node
class_name TestNode

@export
var dictionary: Dictionary[String, String] = {}

func _init() -> void:
	self.dictionary = {}

func _ready() -> void:
	Log.trace.call(self.dictionary, {
		"fileName": "src/test/TestNode.hx",
		"lineNumber": 11,
		"className": "test.TestNode",
		"methodName": "_ready"
	})

