class_name TestString



static func test():
	var str = String.new("Test")
	
	Log.trace(str, {
		"fileName": "haxe-src/TestString.hx"
		"lineNumber": 7
		"className": "TestString"
		"methodName": "test",
	})
	
	var v = randf()
	var tempRight = int(floor(v))
	var str2 = char(65 + tempRight)
	
	Log.trace(str2, {
		"fileName": "haxe-src/TestString.hx"
		"lineNumber": 10
		"className": "TestString"
		"methodName": "test",
	})
	
	var fd = str.length()
	
	str2[43]