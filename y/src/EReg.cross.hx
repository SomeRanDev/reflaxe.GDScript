package;

class EReg {
	private var regObj: Dynamic;
	private var regexStr: String;
	private var m: Dynamic = null;

	public function new(r: String, opt: String) {
		regObj = untyped __gdscript__("RegEx.new()");
		regexStr = r;
	}

	private function reset() {
		untyped regObj.clear();
		untyped regObj.compile(regexStr);
	}

	public function match(s: String): Bool {
		reset();
		m = untyped regObj.search(s);
		return untyped !!m;
	}

	public function matched(n: Int): String {
		if(m != null) {
			return m.get_string(n);
		}
		return "";
	}

	public function matchedLeft(): String {
		throw "EReg.matchedLeft not implemented for GDScript.";
	}

	public function matchedRight(): String {
		throw "EReg.matchedRight not implemented for GDScript.";
	}

	public function matchedPos(): { pos: Int, len: Int } {
		if(m == null) {
			return { pos: -1, len: -1 };
		}
		return untyped {
			pos: m.get_start(),
			len: m.get_end() - m.get_start()
		};
	}

	public function matchSub(s: String, pos: Int, len: Int = -1): Bool {
		reset();
		m = untyped regObj.search(s, pos, (len == -1 ? -1 : (s.length - pos + len)));
		return untyped !!m;
	}

	public function split(s: String): Array<String> {
		if(s == null || s.length <= 0) {
			return [s];
		}

		final result = [];
		var index = 0;
		while(true) {
			if(matchSub(s, index)) {
				final pos = matchedPos();
				result.push(s.substring(index, pos.pos));

				// prevent infinite loop
				if((pos.pos + pos.len) <= index) {
					break;
				}

				index = pos.pos + pos.len;

				if(index >= s.length) {
					break;
				}

			} else {
				result.push(s.substring(index));
				break;
			}
		}

		return result;
	}

	public function replace(s: String, by: String): String {
		return untyped regObj.sub(s, by);
	}

	public function map(s: String, f: (EReg)->String): String {
		throw "EReg.map not implemented for GDScript.";
	}

	public static function escape(s: String): String {
		throw "EReg.escape not implemented for GDScript.";
	}
}
