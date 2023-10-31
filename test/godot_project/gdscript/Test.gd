extends Node
class_name Test

func _init():
	TestAll.test();

func _ready():
	get_tree().quit(0);
