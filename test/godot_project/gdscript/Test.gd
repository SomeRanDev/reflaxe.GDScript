extends Node
class_name Test

func _init():
	TestAll.test();

func _ready():
	call_deferred("quit");

func quit(): pass
	# quits too soon for some reason?? Fix later
	# get_tree().quit(0);
