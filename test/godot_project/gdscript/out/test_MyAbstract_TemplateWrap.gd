class_name TemplateWrap_Impl_

func _init() -> void:
	pass

static func _new(x: String) -> haxe_Template:
	var this1: haxe_Template = haxe_Template.new(x)

	return this1

static func __get(this1: haxe_Template) -> haxe_Template:
	return this1

static func fromString(s: String) -> haxe_Template:
	var this1: haxe_Template = haxe_Template.new(s)
	var tempResult: haxe_Template = this1

	return tempResult

static func toString(this1: haxe_Template) -> String:
	return this1.execute({
		"t": "really works!"
	}, null)

