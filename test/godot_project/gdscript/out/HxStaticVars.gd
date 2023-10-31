extends Node

var _Log: Dictionary = {
	"trace": func(v, infos = null):
	var _str = Log.formatOutput(v, infos)
	print(_str)
}

var _OtherClass: Dictionary = {
	"_str": "",
	"add": func():
	HxStaticVars._OtherClass._str += "|"
}

var _TestStaticVar: Dictionary = {
	"count": 0
}

