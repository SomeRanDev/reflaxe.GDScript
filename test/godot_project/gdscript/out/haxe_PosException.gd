extends Exception
class_name PosException

var posInfos: Variant

func _init(message: String, previous = null, pos = null) -> void:
	super(message, previous)

	if (pos == null):
		self.posInfos = {
			"fileName": "(unknown)",
			"lineNumber": 0,
			"className": "(unknown)",
			"methodName": "(unknown)"
		}
	else:
		self.posInfos = pos

func toString() -> String:
	return "" + super.toString() + " in " + self.posInfos.get("className") + "." + self.posInfos.get("methodName") + " at " + self.posInfos.get("fileName") + ":" + str(self.posInfos.get("lineNumber"))

