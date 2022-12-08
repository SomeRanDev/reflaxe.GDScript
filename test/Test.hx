
class Test {
	public var bla: Int = 2 + 2;

	public var fdsfds(get, set): Int;

	public function get_fdsfds() return 43;
	public function set_fdsfds(v) return 54;

	public function new() {
		bla++;
		trace(bla);
	}

	public function fds() {
		trace(bla);

		var a = 0.0;
		var b = if(a > Math.random()) {
			a = 0;
			a + a;
		} else {
			a;
		}

		fdsfds = 54;

		if(a < Math.random()) {}

		switch(a) {
			case 2.0 | 4.0 if(a < Math.random()): {
				trace("2.0");
			}
			case _: {
				trace("fjdksl");
			}
		}

		trace(b);

		var fd = [436, 765, 43];
		var c = fd[{
			var a = 1;
			{
				if(a > Math.random()) {
					a = 0;
					a + a;
				} else {
					a;
				}
			}
		}];

		trace(c);

		var a = if(a > Math.random()) {
			var fff = "444" + Std.string(Math.random());
			fff + fff;
		} else {
			"jkljkl";
		}
		trace('$a is a number');
	}
}
