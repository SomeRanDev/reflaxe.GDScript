class_name TestMap

func _init() -> void:
	pass

static func test() -> void:
	var map: StringMap = StringMap.new()

	if true:
		var cond: bool = map.exists("foo") == false
		assert(cond, "Test assert failed.")
	if true:
		var cond: bool = map.__get("foo") == null
		assert(cond, "Test assert failed.")

	map.__set("foo", 1)
	map.__set("bar", 2)
	map.__set("baz", 3)

	var dynmap = map
	var map2: Variant = dynmap
	var map3: Variant = dynmap
	var map4: Variant = dynmap

	if true:
		var cond: bool = ((map as Variant) is StringMap) == true
		assert(cond, "Test assert failed.")
	if true:
		var cond: bool = map.exists("foo") == true
		assert(cond, "Test assert failed.")
	if true:
		var cond: bool = map.exists("bar") == true
		assert(cond, "Test assert failed.")
	if true:
		var cond: bool = map.exists("baz") == true
		assert(cond, "Test assert failed.")
	if true:
		var cond: bool = map.__get("foo") == 1
		assert(cond, "Test assert failed.")
	if true:
		var cond: bool = map.__get("bar") == 2
		assert(cond, "Test assert failed.")
	if true:
		var cond: bool = map.__get("baz") == 3
		assert(cond, "Test assert failed.")
	if true:
		var cond: bool = map2.exists("foo") == true
		assert(cond, "Test assert failed.")
	if true:
		var cond: bool = map2.__get("foo") == 1
		assert(cond, "Test assert failed.")
	if true:
		var cond: bool = map3.exists("foo") == true
		assert(cond, "Test assert failed.")
	if true:
		var cond: bool = map3.__get("foo") == 1
		assert(cond, "Test assert failed.")
	if true:
		var cond: bool = map4.exists("foo") == true
		assert(cond, "Test assert failed.")
	if true:
		var cond: bool = map4.__get("foo") == 1
		assert(cond, "Test assert failed.")

	var copied: StringMap = map.copy()

	assert(copied != map, "Test assert failed.")

	if true:
		var cond: bool = copied.exists("foo") == map.exists("foo")
		assert(cond, "Test assert failed.")
	if true:
		var cond: bool = copied.exists("bar") == map.exists("bar")
		assert(cond, "Test assert failed.")
	if true:
		var cond: bool = copied.exists("baz") == map.exists("baz")
		assert(cond, "Test assert failed.")
	if true:
		var cond: bool = copied.__get("foo") == map.__get("foo")
		assert(cond, "Test assert failed.")
	if true:
		var cond: bool = copied.__get("bar") == map.__get("bar")
		assert(cond, "Test assert failed.")
	if true:
		var cond: bool = copied.__get("baz") == map.__get("baz")
		assert(cond, "Test assert failed.")

	copied.__set("foo", 4)

	if true:
		var cond: bool = copied.__get("foo") == 4
		assert(cond, "Test assert failed.")
	if true:
		var cond: bool = map.__get("foo") == 1
		assert(cond, "Test assert failed.")

	var values: Array[int] = ([] as Array[int])

	if true:
		var val: Variant = map.iterator()
		while (val.get("hasNext").call()):
			var val2: int = val.get("next").call()
			values.push_back(val2)
	if true:
		var cond: bool = values.size() == 3
		assert(cond, "Test assert failed.")
	if true:
		var cond: bool = ([1, 2, 3] as Array[int]).has(values[0])
		assert(cond, "Test assert failed.")
	if true:
		var cond: bool = ([1, 2, 3] as Array[int]).has(values[1])
		assert(cond, "Test assert failed.")
	if true:
		var cond: bool = ([1, 2, 3] as Array[int]).has(values[2])
		assert(cond, "Test assert failed.")

	var keys: Array[String] = (["foo", "bar", "baz"] as Array[String])

	if true:
		var key: Variant = map.keys()
		while (key.get("hasNext").call()):
			var key2: String = key.get("next").call()
			if true:
				var tempBool
				if true:
					var index: int = keys.find(key2)
					if (index >= 0):
						keys.remove_at(index)
						tempBool = true
					else:
						tempBool = false
				var cond: bool = tempBool
				assert(cond, "Test assert failed.")

	assert(keys == ([] as Array[String]), "Test assert failed.")

	if true:
		var cond: bool = map.remove("bar") == true
		assert(cond, "Test assert failed.")
	if true:
		var cond: bool = map.remove("bar") == false
		assert(cond, "Test assert failed.")
	if true:
		var cond: bool = map.exists("foo") == true
		assert(cond, "Test assert failed.")
	if true:
		var cond: bool = map.exists("bar") == false
		assert(cond, "Test assert failed.")
	if true:
		var cond: bool = map.exists("baz") == true
		assert(cond, "Test assert failed.")
	if true:
		var cond: bool = map.__get("bar") == null
		assert(cond, "Test assert failed.")

	var tempMap

	if true:
		var _g: IntMap = IntMap.new()
		_g.__set(1, "2")
		_g.__set(2, "4")
		_g.__set(3, "6")
		tempMap = _g

	var tempArray

	if true:
		var _g: Array[int] = ([] as Array[int])
		if true:
			var map6: Variant = tempMap
			var _g_keys: Variant = map6.keys()
			while (_g_keys.get("hasNext").call()):
				var _g_value
				var _g_key
				var key: int = _g_keys.get("next").call()
				_g_value = map6.__get(key)
				_g_key = key
				var k: int = _g_key
				var v: String = _g_value
				_g.push_back(k)
		tempArray = _g

	tempArray.sort_custom(func(a: int, b: int) -> bool:
		return Reflect.compare(a, b) < 0)
	assert(tempArray == ([1, 2, 3] as Array[int]), "Test assert failed.")

	var tempArray1

	if true:
		var _g: Array[String] = ([] as Array[String])
		if true:
			var map6: Variant = tempMap
			var _g_keys: Variant = map6.keys()
			while (_g_keys.get("hasNext").call()):
				var _g_value
				var _g_key
				var key: int = _g_keys.get("next").call()
				_g_value = map6.__get(key)
				_g_key = key
				var k: int = _g_key
				var v: String = _g_value
				_g.push_back(v)
		tempArray1 = _g

	tempArray1.sort_custom(func(a: String, b: String) -> bool:
		return Reflect.compare(a, b) < 0)
	assert(tempArray1 == (["2", "4", "6"] as Array[String]), "Test assert failed.")

	var map6: IntMap = IntMap.new()

	if true:
		var cond: bool = map6.exists(1) == false
		assert(cond, "Test assert failed.")
	if true:
		var cond: bool = map6.__get(1) == null
		assert(cond, "Test assert failed.")

	map6.__set(1, 1)
	map6.__set(2, 2)
	map6.__set(3, 3)

	if true:
		var cond: bool = ((map6 as Variant) is IntMap) == true
		assert(cond, "Test assert failed.")
	if true:
		var cond: bool = map6.exists(1) == true
		assert(cond, "Test assert failed.")
	if true:
		var cond: bool = map6.exists(2) == true
		assert(cond, "Test assert failed.")
	if true:
		var cond: bool = map6.exists(3) == true
		assert(cond, "Test assert failed.")
	if true:
		var cond: bool = map6.__get(1) == 1
		assert(cond, "Test assert failed.")
	if true:
		var cond: bool = map6.__get(2) == 2
		assert(cond, "Test assert failed.")
	if true:
		var cond: bool = map6.__get(3) == 3
		assert(cond, "Test assert failed.")

	var copied2: IntMap = map6.copy()

	assert(copied2 != map6, "Test assert failed.")

	if true:
		var cond: bool = copied2.exists(1) == map6.exists(1)
		assert(cond, "Test assert failed.")
	if true:
		var cond: bool = copied2.exists(2) == map6.exists(2)
		assert(cond, "Test assert failed.")
	if true:
		var cond: bool = copied2.exists(3) == map6.exists(3)
		assert(cond, "Test assert failed.")
	if true:
		var cond: bool = copied2.__get(1) == map6.__get(1)
		assert(cond, "Test assert failed.")
	if true:
		var cond: bool = copied2.__get(2) == map6.__get(2)
		assert(cond, "Test assert failed.")
	if true:
		var cond: bool = copied2.__get(3) == map6.__get(3)
		assert(cond, "Test assert failed.")

	copied2.__set(1, 4)

	if true:
		var cond: bool = copied2.__get(1) == 4
		assert(cond, "Test assert failed.")
	if true:
		var cond: bool = map6.__get(1) == 1
		assert(cond, "Test assert failed.")

	var values3: Array[int] = ([] as Array[int])

	if true:
		var val: Variant = map6.iterator()
		while (val.get("hasNext").call()):
			var val2: int = val.get("next").call()
			values3.push_back(val2)
	if true:
		var cond: bool = values3.size() == 3
		assert(cond, "Test assert failed.")
	if true:
		var cond: bool = ([1, 2, 3] as Array[int]).has(values3[0])
		assert(cond, "Test assert failed.")
	if true:
		var cond: bool = ([1, 2, 3] as Array[int]).has(values3[1])
		assert(cond, "Test assert failed.")
	if true:
		var cond: bool = ([1, 2, 3] as Array[int]).has(values3[2])
		assert(cond, "Test assert failed.")

	var keys3: Array[int] = ([1, 2, 3] as Array[int])

	if true:
		var key: Variant = map6.keys()
		while (key.get("hasNext").call()):
			var key2: int = key.get("next").call()
			if true:
				var tempBool1
				if true:
					var index: int = keys3.find(key2)
					if (index >= 0):
						keys3.remove_at(index)
						tempBool1 = true
					else:
						tempBool1 = false
				var cond: bool = tempBool1
				assert(cond, "Test assert failed.")

	assert(keys3 == ([] as Array[int]), "Test assert failed.")

	if true:
		var cond: bool = map6.remove(2) == true
		assert(cond, "Test assert failed.")
	if true:
		var cond: bool = map6.remove(2) == false
		assert(cond, "Test assert failed.")
	if true:
		var cond: bool = map6.exists(1) == true
		assert(cond, "Test assert failed.")
	if true:
		var cond: bool = map6.exists(2) == false
		assert(cond, "Test assert failed.")
	if true:
		var cond: bool = map6.exists(3) == true
		assert(cond, "Test assert failed.")
	if true:
		var cond: bool = map6.__get(2) == null
		assert(cond, "Test assert failed.")

	var tempMap1

	if true:
		var _g: IntMap = IntMap.new()
		_g.__set(1, 2)
		_g.__set(2, 4)
		_g.__set(3, 6)
		tempMap1 = _g

	var tempArray2

	if true:
		var _g: Array[int] = ([] as Array[int])
		if true:
			var map8: Variant = tempMap1
			var _g_keys: Variant = map8.keys()
			while (_g_keys.get("hasNext").call()):
				var _g_value
				var _g_key
				var key: int = _g_keys.get("next").call()
				_g_value = map8.__get(key)
				_g_key = key
				var k: int = _g_key
				var v: int = _g_value
				_g.push_back(k)
		tempArray2 = _g

	tempArray2.sort_custom(func(a: int, b: int) -> bool:
		return Reflect.compare(a, b) < 0)
	assert(tempArray2 == ([1, 2, 3] as Array[int]), "Test assert failed.")

	var tempArray3

	if true:
		var _g: Array[int] = ([] as Array[int])
		if true:
			var map8: Variant = tempMap1
			var _g_keys: Variant = map8.keys()
			while (_g_keys.get("hasNext").call()):
				var _g_value
				var _g_key
				var key: int = _g_keys.get("next").call()
				_g_value = map8.__get(key)
				_g_key = key
				var k: int = _g_key
				var v: int = _g_value
				_g.push_back(v)
		tempArray3 = _g

	tempArray3.sort_custom(func(a: int, b: int) -> bool:
		return Reflect.compare(a, b) < 0)
	assert(tempArray3 == ([2, 4, 6] as Array[int]), "Test assert failed.")

	var map8: ObjectMap = ObjectMap.new()
	var a: ClassWithHashCode = ClassWithHashCode.new(1)
	var b: ClassWithHashCode = ClassWithHashCode.new(2)
	var c: ClassWithHashCode = ClassWithHashCode.new(3)

	if true:
		var cond: bool = map8.exists(a) == false
		assert(cond, "Test assert failed.")
	if true:
		var cond: bool = map8.__get(a) == null
		assert(cond, "Test assert failed.")

	map8.__set(a, 1)
	map8.__set(b, 2)
	map8.__set(c, 3)

	if true:
		var cond: bool = map8.exists(a) == true
		assert(cond, "Test assert failed.")
	if true:
		var cond: bool = map8.exists(b) == true
		assert(cond, "Test assert failed.")
	if true:
		var cond: bool = map8.exists(c) == true
		assert(cond, "Test assert failed.")
	if true:
		var cond: bool = map8.__get(a) == 1
		assert(cond, "Test assert failed.")
	if true:
		var cond: bool = map8.__get(b) == 2
		assert(cond, "Test assert failed.")
	if true:
		var cond: bool = map8.__get(c) == 3
		assert(cond, "Test assert failed.")

	var tempArray4

	if true:
		var _g: Array[ClassWithHashCode] = ([] as Array[ClassWithHashCode])
		if true:
			var map9: Variant = map8
			var _g_keys: Variant = map9.keys()
			while (_g_keys.get("hasNext").call()):
				var _g_value
				var _g_key
				var key: ClassWithHashCode = _g_keys.get("next").call()
				_g_value = map9.__get(key)
				_g_key = key
				var k: ClassWithHashCode = _g_key
				var v: int = _g_value
				_g.push_back(k)
		tempArray4 = _g
	if true:
		var cond: bool = ([a, b, c] as Array[ClassWithHashCode]).has(tempArray4[0])
		assert(cond, "Test assert failed.")
	if true:
		var cond: bool = ([a, b, c] as Array[ClassWithHashCode]).has(tempArray4[1])
		assert(cond, "Test assert failed.")
	if true:
		var cond: bool = ([a, b, c] as Array[ClassWithHashCode]).has(tempArray4[2])
		assert(cond, "Test assert failed.")

	var tempArray5

	if true:
		var _g: Array[int] = ([] as Array[int])
		if true:
			var map9: Variant = map8
			var _g_keys: Variant = map9.keys()
			while (_g_keys.get("hasNext").call()):
				var _g_value
				var _g_key
				var key: ClassWithHashCode = _g_keys.get("next").call()
				_g_value = map9.__get(key)
				_g_key = key
				var k: ClassWithHashCode = _g_key
				var v: int = _g_value
				_g.push_back(v)
		tempArray5 = _g
	if true:
		var cond: bool = ([1, 2, 3] as Array[int]).has(tempArray5[0])
		assert(cond, "Test assert failed.")
	if true:
		var cond: bool = ([1, 2, 3] as Array[int]).has(tempArray5[1])
		assert(cond, "Test assert failed.")
	if true:
		var cond: bool = ([1, 2, 3] as Array[int]).has(tempArray5[2])
		assert(cond, "Test assert failed.")

	var copied3: ObjectMap = map8.copy()

	assert(copied3 != map8, "Test assert failed.")

	if true:
		var cond: bool = copied3.exists(a) == map8.exists(a)
		assert(cond, "Test assert failed.")
	if true:
		var cond: bool = copied3.exists(b) == map8.exists(b)
		assert(cond, "Test assert failed.")
	if true:
		var cond: bool = copied3.exists(c) == map8.exists(c)
		assert(cond, "Test assert failed.")
	if true:
		var cond: bool = copied3.__get(a) == map8.__get(a)
		assert(cond, "Test assert failed.")
	if true:
		var cond: bool = copied3.__get(b) == map8.__get(b)
		assert(cond, "Test assert failed.")
	if true:
		var cond: bool = copied3.__get(c) == map8.__get(c)
		assert(cond, "Test assert failed.")

	copied3.__set(a, 4)

	if true:
		var cond: bool = copied3.__get(a) == 4
		assert(cond, "Test assert failed.")
	if true:
		var cond: bool = map8.__get(a) == 1
		assert(cond, "Test assert failed.")

	var values6: Array[int] = ([] as Array[int])

	if true:
		var val: Variant = map8.iterator()
		while (val.get("hasNext").call()):
			var val2: int = val.get("next").call()
			values6.push_back(val2)
	if true:
		var cond: bool = values6.size() == 3
		assert(cond, "Test assert failed.")
	if true:
		var cond: bool = ([1, 2, 3] as Array[int]).has(values6[0])
		assert(cond, "Test assert failed.")
	if true:
		var cond: bool = ([1, 2, 3] as Array[int]).has(values6[1])
		assert(cond, "Test assert failed.")
	if true:
		var cond: bool = ([1, 2, 3] as Array[int]).has(values6[2])
		assert(cond, "Test assert failed.")

	var keys6: Array[ClassWithHashCode] = ([a, b, c] as Array[ClassWithHashCode])

	if true:
		var key: Variant = map8.keys()
		while (key.get("hasNext").call()):
			var key2: ClassWithHashCode = key.get("next").call()
			if true:
				var tempBool2
				if true:
					var index: int = keys6.find(key2)
					if (index >= 0):
						keys6.remove_at(index)
						tempBool2 = true
					else:
						tempBool2 = false
				var cond: bool = tempBool2
				assert(cond, "Test assert failed.")

	assert(keys6 == ([] as Array[ClassWithHashCode]), "Test assert failed.")

	if true:
		var cond: bool = map8.remove(b) == true
		assert(cond, "Test assert failed.")
	if true:
		var cond: bool = map8.remove(b) == false
		assert(cond, "Test assert failed.")
	if true:
		var cond: bool = map8.exists(a) == true
		assert(cond, "Test assert failed.")
	if true:
		var cond: bool = map8.exists(b) == false
		assert(cond, "Test assert failed.")
	if true:
		var cond: bool = map8.exists(c) == true
		assert(cond, "Test assert failed.")
	if true:
		var cond: bool = map8.__get(b) == null
		assert(cond, "Test assert failed.")

	var map9: ObjectMap = ObjectMap.new()
	var a2: ClassWithoutHashCode = ClassWithoutHashCode.new(1)
	var b2: ClassWithoutHashCode = ClassWithoutHashCode.new(2)
	var c2: ClassWithoutHashCode = ClassWithoutHashCode.new(3)

	if true:
		var cond: bool = map9.exists(a2) == false
		assert(cond, "Test assert failed.")
	if true:
		var cond: bool = map9.__get(a2) == null
		assert(cond, "Test assert failed.")

	map9.__set(a2, 1)
	map9.__set(b2, 2)
	map9.__set(c2, 3)

	if true:
		var cond: bool = map9.exists(a2) == true
		assert(cond, "Test assert failed.")
	if true:
		var cond: bool = map9.exists(b2) == true
		assert(cond, "Test assert failed.")
	if true:
		var cond: bool = map9.exists(c2) == true
		assert(cond, "Test assert failed.")
	if true:
		var cond: bool = map9.__get(a2) == 1
		assert(cond, "Test assert failed.")
	if true:
		var cond: bool = map9.__get(b2) == 2
		assert(cond, "Test assert failed.")
	if true:
		var cond: bool = map9.__get(c2) == 3
		assert(cond, "Test assert failed.")

	var tempArray6

	if true:
		var _g: Array[ClassWithoutHashCode] = ([] as Array[ClassWithoutHashCode])
		if true:
			var map10: Variant = map9
			var _g_keys: Variant = map10.keys()
			while (_g_keys.get("hasNext").call()):
				var _g_value
				var _g_key
				var key: ClassWithoutHashCode = _g_keys.get("next").call()
				_g_value = map10.__get(key)
				_g_key = key
				var k: ClassWithoutHashCode = _g_key
				var v: int = _g_value
				_g.push_back(k)
		tempArray6 = _g
	if true:
		var cond: bool = ([a2, b2, c2] as Array[ClassWithoutHashCode]).has(tempArray6[0])
		assert(cond, "Test assert failed.")
	if true:
		var cond: bool = ([a2, b2, c2] as Array[ClassWithoutHashCode]).has(tempArray6[1])
		assert(cond, "Test assert failed.")
	if true:
		var cond: bool = ([a2, b2, c2] as Array[ClassWithoutHashCode]).has(tempArray6[2])
		assert(cond, "Test assert failed.")

	var tempArray7

	if true:
		var _g: Array[int] = ([] as Array[int])
		if true:
			var map10: Variant = map9
			var _g_keys: Variant = map10.keys()
			while (_g_keys.get("hasNext").call()):
				var _g_value
				var _g_key
				var key: ClassWithoutHashCode = _g_keys.get("next").call()
				_g_value = map10.__get(key)
				_g_key = key
				var k: ClassWithoutHashCode = _g_key
				var v: int = _g_value
				_g.push_back(v)
		tempArray7 = _g
	if true:
		var cond: bool = ([1, 2, 3] as Array[int]).has(tempArray7[0])
		assert(cond, "Test assert failed.")
	if true:
		var cond: bool = ([1, 2, 3] as Array[int]).has(tempArray7[1])
		assert(cond, "Test assert failed.")
	if true:
		var cond: bool = ([1, 2, 3] as Array[int]).has(tempArray7[2])
		assert(cond, "Test assert failed.")

	var copied4: ObjectMap = map9.copy()

	assert(copied4 != map9, "Test assert failed.")

	if true:
		var cond: bool = copied4.exists(a2) == map9.exists(a2)
		assert(cond, "Test assert failed.")
	if true:
		var cond: bool = copied4.exists(b2) == map9.exists(b2)
		assert(cond, "Test assert failed.")
	if true:
		var cond: bool = copied4.exists(c2) == map9.exists(c2)
		assert(cond, "Test assert failed.")
	if true:
		var cond: bool = copied4.__get(a2) == map9.__get(a2)
		assert(cond, "Test assert failed.")
	if true:
		var cond: bool = copied4.__get(b2) == map9.__get(b2)
		assert(cond, "Test assert failed.")
	if true:
		var cond: bool = copied4.__get(c2) == map9.__get(c2)
		assert(cond, "Test assert failed.")

	copied4.__set(a2, 4)

	if true:
		var cond: bool = copied4.__get(a2) == 4
		assert(cond, "Test assert failed.")
	if true:
		var cond: bool = map9.__get(a2) == 1
		assert(cond, "Test assert failed.")

	var values8: Array[int] = ([] as Array[int])

	if true:
		var val: Variant = map9.iterator()
		while (val.get("hasNext").call()):
			var val2: int = val.get("next").call()
			values8.push_back(val2)
	if true:
		var cond: bool = values8.size() == 3
		assert(cond, "Test assert failed.")
	if true:
		var cond: bool = ([1, 2, 3] as Array[int]).has(values8[0])
		assert(cond, "Test assert failed.")
	if true:
		var cond: bool = ([1, 2, 3] as Array[int]).has(values8[1])
		assert(cond, "Test assert failed.")
	if true:
		var cond: bool = ([1, 2, 3] as Array[int]).has(values8[2])
		assert(cond, "Test assert failed.")

	var keys8: Array[ClassWithoutHashCode] = ([a2, b2, c2] as Array[ClassWithoutHashCode])

	if true:
		var key: Variant = map9.keys()
		while (key.get("hasNext").call()):
			var key2: ClassWithoutHashCode = key.get("next").call()
			if true:
				var tempBool3
				if true:
					var index: int = keys8.find(key2)
					if (index >= 0):
						keys8.remove_at(index)
						tempBool3 = true
					else:
						tempBool3 = false
				var cond: bool = tempBool3
				assert(cond, "Test assert failed.")

	assert(keys8 == ([] as Array[ClassWithoutHashCode]), "Test assert failed.")

	if true:
		var cond: bool = map9.remove(b2) == true
		assert(cond, "Test assert failed.")
	if true:
		var cond: bool = map9.remove(b2) == false
		assert(cond, "Test assert failed.")
	if true:
		var cond: bool = map9.exists(a2) == true
		assert(cond, "Test assert failed.")
	if true:
		var cond: bool = map9.exists(b2) == false
		assert(cond, "Test assert failed.")
	if true:
		var cond: bool = map9.exists(c2) == true
		assert(cond, "Test assert failed.")
	if true:
		var cond: bool = map9.__get(b2) == null
		assert(cond, "Test assert failed.")

	var map10: StringMap = StringMap.new()

	if true:
		var cond: bool = map10.__get("foo") == null
		assert(cond, "Test assert failed.")

	map10.__set("foo", 12)

	var tempNumber: int = 12

	tempNumber

	if true:
		var cond: bool = map10.__get("foo") == 12
		assert(cond, "Test assert failed.")
	if true:
		var cond: bool = map10.__get("foo") == 12
		assert(cond, "Test assert failed.")
	if true:
		if true:
			var v: int = map10.__get("foo") + 2
			map10.__set("foo", v)
			v
	if true:
		var cond: bool = map10.__get("foo") == 14
		assert(cond, "Test assert failed.")
	if true:
		var cond: bool = map10.__get("foo") == 14
		assert(cond, "Test assert failed.")
	if true:
		if true:
			var v: int = map10.__get("foo") * (map10.__get("foo") + 2)
			map10.__set("foo", v)
			v
	if true:
		var cond: bool = map10.__get("foo") == 224
		assert(cond, "Test assert failed.")
	if true:
		if true:
			var v: int = map10.__get("f" + "o" + "o") - 223
			map10.__set("f" + "o" + "o", v)
			v
	if true:
		var tempLeft
		if true:
			var key: String = (func(s: String) -> String:
				return s + "o").call("fo")
			tempLeft = map10.__get(key)
		var cond: bool = tempLeft == 1
		assert(cond, "Test assert failed.")
	if true:
		var tempNumber1
		if true:
			map10.__set("foo", 9)
			tempNumber1 = 9
		var v: int = tempNumber1
		map10.__set("bar", v)
		v
	if true:
		var cond: bool = map10.__get("bar") == 9
		assert(cond, "Test assert failed.")
	if true:
		var cond: bool = map10.__get("foo") == 9
		assert(cond, "Test assert failed.")
	if true:
		var tempIterator
		if true:
			var tempMap2
			if true:
				var _g: StringMap = StringMap.new()
				_g.__set("", "")
				tempMap2 = _g
			var this1: Variant = tempMap2
			tempIterator = this1.keys()
		var cond: bool = (tempIterator).get("next").call() == ""
		assert(cond, "Test assert failed.")
	if true:
		var tempIterator1
		if true:
			var tempMap3
			if true:
				var _g: StringMap = StringMap.new()
				_g.__set("", "")
				tempMap3 = _g
			var this1: Variant = tempMap3
			tempIterator1 = this1.iterator()
		var cond: bool = (tempIterator1).get("next").call() == ""
		assert(cond, "Test assert failed.")
	if true:
		var tempIterator2
		if true:
			var tempMap4
			if true:
				var _g: IntMap = IntMap.new()
				_g.__set(2, 3)
				tempMap4 = _g
			var this1: Variant = tempMap4
			tempIterator2 = this1.keys()
		var cond: bool = (tempIterator2).get("next").call() == 2
		assert(cond, "Test assert failed.")
	if true:
		var tempIterator3
		if true:
			var tempMap5
			if true:
				var _g: IntMap = IntMap.new()
				_g.__set(2, 3)
				tempMap5 = _g
			var this1: Variant = tempMap5
			tempIterator3 = this1.iterator()
		var cond: bool = (tempIterator3).get("next").call() == 3
		assert(cond, "Test assert failed.")

	assert("TType(Map,[TInst(String,[]),TAbstract(Int,[])])" == "TType(Map,[TInst(String,[]),TAbstract(Int,[])])", "Test assert failed.")
	assert(true == true, "Test assert failed.")

	if true:
		var tempLeft1
		if true:
			var tempMap6
			if true:
				var _g: StringMap = StringMap.new()
				_g.__set("", "")
				tempMap6 = _g
			var this1: Variant = tempMap6
			var inlMapKeyValueIterator_keys: Variant = this1.keys()
			var key: String = inlMapKeyValueIterator_keys.get("next").call()
			var inlobj_value: String = this1.__get(key)
			var inlobj_key: String = key
			tempLeft1 = inlobj_key
		var cond: bool = tempLeft1 == ""
		assert(cond, "Test assert failed.")
	if true:
		var tempLeft2
		if true:
			var tempMap7
			if true:
				var _g: StringMap = StringMap.new()
				_g.__set("", "")
				tempMap7 = _g
			var this1: Variant = tempMap7
			var inlMapKeyValueIterator_keys: Variant = this1.keys()
			var key: String = inlMapKeyValueIterator_keys.get("next").call()
			var inlobj_value: String = this1.__get(key)
			var inlobj_key: String = key
			tempLeft2 = inlobj_value
		var cond: bool = tempLeft2 == ""
		assert(cond, "Test assert failed.")
	if true:
		var tempLeft3
		if true:
			var tempMap8
			if true:
				var _g: IntMap = IntMap.new()
				_g.__set(2, 3)
				tempMap8 = _g
			var this1: Variant = tempMap8
			var inlMapKeyValueIterator_keys: Variant = this1.keys()
			var key: int = inlMapKeyValueIterator_keys.get("next").call()
			var inlobj_value: int = this1.__get(key)
			var inlobj_key: int = key
			tempLeft3 = inlobj_key
		var cond: bool = tempLeft3 == 2
		assert(cond, "Test assert failed.")
	if true:
		var tempLeft4
		if true:
			var tempMap9
			if true:
				var _g: IntMap = IntMap.new()
				_g.__set(2, 3)
				tempMap9 = _g
			var this1: Variant = tempMap9
			var inlMapKeyValueIterator_keys: Variant = this1.keys()
			var key: int = inlMapKeyValueIterator_keys.get("next").call()
			var inlobj_value: int = this1.__get(key)
			var inlobj_key: int = key
			tempLeft4 = inlobj_value
		var cond: bool = tempLeft4 == 3
		assert(cond, "Test assert failed.")

	var tempMap10

	if true:
		var _g: IntMap = IntMap.new()
		_g.__set(1, "2")
		_g.__set(2, "4")
		tempMap10 = _g

	var iterable: Variant = tempMap10
	var tempArray8

	if true:
		var _g: Array[String] = ([] as Array[String])
		if true:
			var kv: Variant = iterable.get("keyValueIterator").call()
			while (kv.get("hasNext").call()):
				var kv2: Variant = kv.get("next").call()
				_g.push_back(kv2.get("value"))
		tempArray8 = _g
	if true:
		var cond: bool = (["2", "4"] as Array[String]).has(tempArray8[0])
		assert(cond, "Test assert failed.")
	if true:
		var cond: bool = (["2", "4"] as Array[String]).has(tempArray8[1])
		assert(cond, "Test assert failed.")

	var iterator: Variant = iterable.get("keyValueIterator").call()
	var tempArray9

	if true:
		var _g: Array[int] = ([] as Array[int])
		if true:
			while (iterator.get("hasNext").call()):
				var kv2: Variant = iterator.get("next").call()
				_g.push_back(kv2.get("key"))
		tempArray9 = _g
	if true:
		var cond: bool = ([1, 2] as Array[int]).has(tempArray9[0])
		assert(cond, "Test assert failed.")
	if true:
		var cond: bool = ([1, 2] as Array[int]).has(tempArray9[1])
		assert(cond, "Test assert failed.")

	var tempMap11

	if true:
		var _g: IntMap = IntMap.new()
		_g.__set(1, "2")
		_g.__set(2, "4")
		tempMap11 = _g

	var dyn = tempMap11
	var it = dyn.iterator.call()
	var it2: Variant = it
	var tempArray10

	if true:
		var _g: Array[String] = ([] as Array[String])
		if true:
			while (it2.get("hasNext").call()):
				var v2: String = it2.get("next").call()
				_g.push_back(v2)
		tempArray10 = _g
	if true:
		var cond: bool = (["2", "4"] as Array[String]).has(tempArray10[0])
		assert(cond, "Test assert failed.")
	if true:
		var cond: bool = (["2", "4"] as Array[String]).has(tempArray10[1])
		assert(cond, "Test assert failed.")

	var it3 = dyn.keyValueIterator.call()
	var it4: Variant = it3
	var tempArray11

	if true:
		var _g: Array[String] = ([] as Array[String])
		if true:
			while (it4.get("hasNext").call()):
				var kv2: Variant = it4.get("next").call()
				_g.push_back(kv2.get("value"))
		tempArray11 = _g
	if true:
		var cond: bool = (["2", "4"] as Array[String]).has(tempArray11[0])
		assert(cond, "Test assert failed.")
	if true:
		var cond: bool = (["2", "4"] as Array[String]).has(tempArray11[1])
		assert(cond, "Test assert failed.")

	var it5 = dyn.keyValueIterator.call()
	var it6: Variant = it5
	var tempArray12

	if true:
		var _g: Array[int] = ([] as Array[int])
		if true:
			while (it6.get("hasNext").call()):
				var kv2: Variant = it6.get("next").call()
				_g.push_back(kv2.get("key"))
		tempArray12 = _g
	if true:
		var cond: bool = ([1, 2] as Array[int]).has(tempArray12[0])
		assert(cond, "Test assert failed.")
	if true:
		var cond: bool = ([1, 2] as Array[int]).has(tempArray12[1])
		assert(cond, "Test assert failed.")

	var tempMap12

	if true:
		var _g: StringMap = StringMap.new()
		_g.__set("1a", "2")
		_g.__set("1b", "4")
		tempMap12 = _g

	var dyn2 = tempMap12
	var it7 = dyn2.iterator.call()
	var it8: Variant = it7
	var tempArray13

	if true:
		var _g: Array[String] = ([] as Array[String])
		if true:
			while (it8.get("hasNext").call()):
				var v2: String = it8.get("next").call()
				_g.push_back(v2)
		tempArray13 = _g
	if true:
		var cond: bool = (["2", "4"] as Array[String]).has(tempArray13[0])
		assert(cond, "Test assert failed.")
	if true:
		var cond: bool = (["2", "4"] as Array[String]).has(tempArray13[1])
		assert(cond, "Test assert failed.")

	var it9 = dyn2.keyValueIterator.call()
	var it10: Variant = it9
	var tempArray14

	if true:
		var _g: Array[String] = ([] as Array[String])
		if true:
			while (it10.get("hasNext").call()):
				var kv2: Variant = it10.get("next").call()
				_g.push_back(kv2.get("value"))
		tempArray14 = _g
	if true:
		var cond: bool = (["2", "4"] as Array[String]).has(tempArray14[0])
		assert(cond, "Test assert failed.")
	if true:
		var cond: bool = (["2", "4"] as Array[String]).has(tempArray14[1])
		assert(cond, "Test assert failed.")

	var it11 = dyn2.keyValueIterator.call()
	var it12: Variant = it11
	var tempArray15

	if true:
		var _g: Array[String] = ([] as Array[String])
		if true:
			while (it12.get("hasNext").call()):
				var kv2: Variant = it12.get("next").call()
				_g.push_back(kv2.get("key"))
		tempArray15 = _g
	if true:
		var cond: bool = (["1a", "1b"] as Array[String]).has(tempArray15[0])
		assert(cond, "Test assert failed.")
	if true:
		var cond: bool = (["1a", "1b"] as Array[String]).has(tempArray15[1])
		assert(cond, "Test assert failed.")
