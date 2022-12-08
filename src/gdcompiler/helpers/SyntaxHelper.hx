package gdcompiler.helpers;

class SyntaxHelper {
	public static function tab(s: String): String {

		// maybe replace with:
		// return StringTools.replace(s, "\n", "\n\t");
		// but this easier to understand...

		final lines = s.split("\n");
		for(i in 0...lines.length) {
			lines[i] = "\t" + lines[i];
		}
		return lines.join("\n");
	}
}
