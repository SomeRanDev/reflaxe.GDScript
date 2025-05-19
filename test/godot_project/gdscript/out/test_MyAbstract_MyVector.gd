class_name MyVector_Impl_

func _init() -> void:
	pass

static func get_x(this1: MyPoint3) -> float:
	return this1.x

static func get_y(this1: MyPoint3) -> float:
	return this1.y

static func get_z(this1: MyPoint3) -> float:
	return this1.z

static func set_x(this1: MyPoint3, x: float) -> float:
	this1.x = x

	return this1.x

static func set_y(this1: MyPoint3, y: float) -> float:
	this1.y = y

	return this1.y

static func set_z(this1: MyPoint3, z: float) -> float:
	this1.z = z

	return this1.z

static func add(lhs: MyPoint3, rhs: MyPoint3) -> MyPoint3:
	return MyPoint3.new(MyVector_Impl_.get_x(lhs) + MyVector_Impl_.get_x(rhs), MyVector_Impl_.get_y(lhs) + MyVector_Impl_.get_y(rhs), MyVector_Impl_.get_z(lhs) + MyVector_Impl_.get_z(rhs))

static func scalarAssign(lhs: MyPoint3, rhs: float) -> MyPoint3:
	MyVector_Impl_.set_x(lhs, MyVector_Impl_.get_x(lhs) * rhs)
	MyVector_Impl_.set_y(lhs, MyVector_Impl_.get_y(lhs) * rhs)
	MyVector_Impl_.set_z(lhs, MyVector_Impl_.get_z(lhs) * rhs)

	return lhs

static func scalar(lhs: MyPoint3, rhs: float) -> MyPoint3:
	return MyPoint3.new(MyVector_Impl_.get_x(lhs) * rhs, MyVector_Impl_.get_y(lhs) * rhs, MyVector_Impl_.get_z(lhs) * rhs)

static func invert(t: MyPoint3) -> MyPoint3:
	return MyPoint3.new(-MyVector_Impl_.get_x(t), -MyVector_Impl_.get_y(t), -MyVector_Impl_.get_z(t))

static func __get(this1: MyPoint3) -> MyPoint3:
	return this1

static func toString(this1: MyPoint3) -> String:
	return "(" + str(this1.x) + "," + str(this1.y) + "," + str(this1.z) + ")"

