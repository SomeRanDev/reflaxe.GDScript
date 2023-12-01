class_name TestAll

func _init():
	pass

static func test() -> void:
	TestSyntax.test()
	TestMath.test()
	TestStd.test()
	TestString.test()
	TestStaticVar.test()
	TestArray.test()
	TestEnum.test()
	TestMeta.test()
	TestSys.test()
	TestEReg.test()
	TestReflect.test()
	TestClass.test()
	HxStaticVars._Log.trace.call("Tests successful!!", {
		"fileName": "src/test/TestAll.hx",
		"lineNumber": 18,
		"className": "test.TestAll",
		"methodName": "test"
	})

