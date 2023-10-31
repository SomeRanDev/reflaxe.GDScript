package;

import Assert.assert;

// Most of the Sys class cannot be implemented due to
// GDScript limitations, but most of it is unnecessary
// anyway since GDScript is explicitly used for 
// high-level game coding (as opposed to making command
// line tools).
class TestSys {
	public static function test() {
		assert(Sys.args().length == 0);

		final first = Sys.cpuTime();

		Sys.sleep(0.1);

		// Hopefully this is consistent across all platforms.
		// If not, it can probably be removed.
		assert((Sys.cpuTime() - first) > 10000);
	}
}
