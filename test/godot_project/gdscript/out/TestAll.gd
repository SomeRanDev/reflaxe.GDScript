class_name TestAll

func _init() -> void:
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
	TestSignals.test()
	TestMap.test()
	Log.trace.call("Tests successful!!", {
		"fileName": "src/test/TestAll.hx",
		"lineNumber": 20,
		"className": "test.TestAll",
		"methodName": "test"
	})

