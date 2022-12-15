class_name TestSyntax

var bla

func _init():
	self.bla = 4
	self.bla++
	Log.trace(self.bla, {
		"fileName": "haxe-src/TestSyntax.hx"
		"lineNumber": 13
		"className": "TestSyntax"
		"methodName": "new",
	})

func get_fdsfds():
	return 43

func set_fdsfds(v):
	return 54

func fds():
	Log.trace(self.bla, {
		"fileName": "haxe-src/TestSyntax.hx"
		"lineNumber": 17
		"className": "TestSyntax"
		"methodName": "fds",
	})
	
	var a = 0.0
	var tempNumber = null
	
	if (a > randf()):
		a = 0
		tempNumber = a + a
	else:
		tempNumber = a
	
	var b = tempNumber
	
	self.set_fdsfds(54)
	
	if (a < randf()):
		pass
	
	match ((a)):
		2.0, 4.0:
			if (a < randf()):
				Log.trace("2.0", {
					"fileName": "haxe-src/TestSyntax.hx"
					"lineNumber": 33
					"className": "TestSyntax"
					"methodName": "fds",
				})
			else:
				Log.trace("fjdksl", {
					"fileName": "haxe-src/TestSyntax.hx"
					"lineNumber": 36
					"className": "TestSyntax"
					"methodName": "fds",
				})
		_:
			Log.trace("fjdksl", {
				"fileName": "haxe-src/TestSyntax.hx"
				"lineNumber": 36
				"className": "TestSyntax"
				"methodName": "fds",
			})
	
	Log.trace(b, {
		"fileName": "haxe-src/TestSyntax.hx"
		"lineNumber": 40
		"className": "TestSyntax"
		"methodName": "fds",
	})
	
	var fd = [436, 765, 43]
	var tempIndex = null
	
	if true:
		var a = 1
		if (a > randf()):
			a = 0
			tempIndex = a + a
		else:
			tempIndex = a
	if true:
		var a = 1
		if (a > randf()):
			a = 0
			tempIndex = a + a
		else:
			tempIndex = a
	
	var c = fd[tempIndex]
	
	Log.trace(c, {
		"fileName": "haxe-src/TestSyntax.hx"
		"lineNumber": 55
		"className": "TestSyntax"
		"methodName": "fds",
	})
	
	var tempString = null
	
	if (a > randf()):
		var fff = "444" + String(randf())
		tempString = fff + fff
	else:
		tempString = "jkljkl"
	
	var a = tempString
	
	Log.trace("" + a + " is a number", {
		"fileName": "haxe-src/TestSyntax.hx"
		"lineNumber": 63
		"className": "TestSyntax"
		"methodName": "fds",
	})