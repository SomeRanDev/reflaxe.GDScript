class_name TemplateWrap_Impl_

func _init() -> void:
	pass

static func _new(x: String) -> Template:
	var this1: Template = Template.new(x)

	return this1

static func __get(this1: Template) -> Template:
	return this1

static func fromString(s: String) -> Template:
	var this1: Template = Template.new(s)
	var tempResult: Template = this1

	return tempResult

static func toString(this1: Template) -> String:
	return this1.execute({
		"t": "really works!"
	}, null)

