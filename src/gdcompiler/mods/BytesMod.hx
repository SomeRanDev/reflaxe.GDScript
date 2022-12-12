package gdcompiler.mods;

#if (macro || gdscript_runtime)

import reflaxe.input.ClassModifier;

class BytesMod {
	public static function apply() {
		ClassModifier.mod("haxe.io.Bytes", "getString", macro {
			var s = "";
			var b = b;
			var i = pos;
			var max = pos + len;
			// utf8-decode and utf16-encode
			while (i < max) {
				var c = b[i++];
				if (c < 0x80) {
					if (c == 0)
						break;
					s += String.fromCharCode(c);
				} else if (c < 0xE0)
					s += String.fromCharCode(((c & 0x3F) << 6) | (b[i++] & 0x7F));
				else if (c < 0xF0) {
					var c2 = b[i++];
					s += String.fromCharCode(((c & 0x1F) << 12) | ((c2 & 0x7F) << 6) | (b[i++] & 0x7F));
				} else {
					var c2 = b[i++];
					var c3 = b[i++];
					var u = ((c & 0x0F) << 18) | ((c2 & 0x7F) << 12) | ((c3 & 0x7F) << 6) | (b[i++] & 0x7F);
					// surrogate pair
					s += String.fromCharCode((u >> 10) + 0xD7C0);
					s += String.fromCharCode((u & 0x3FF) | 0xDC00);
				}
			}
			return s;
		});
	}
}

#end
