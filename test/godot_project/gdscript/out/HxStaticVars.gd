extends Node

var _Log: Dictionary = {
	"trace": func(v, infos = null):
	var str: String = Log.formatOutput(v, infos)
	print(str)
}

var _OtherClass: Dictionary = {
	"str": "",
	"add": func():
	HxStaticVars._OtherClass.str += "|"
}

var _TestStaticVar: Dictionary = {
	"count": 0
}

