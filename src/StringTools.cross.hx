import haxe.iterators.StringIterator;
import haxe.iterators.StringKeyValueIterator;

#if cpp
using cpp.NativeString;
#end

class StringTools {
	/**
		Encode an URL by using the standard format.
	**/
	inline public static function urlEncode(s:String):String {
		return "";
	}

	/**
		Decode an URL using the standard format.
	**/
	inline public static function urlDecode(s:String):String {
		return null;
	}

	/**
		Escapes HTML special characters of the string `s`.

		The following replacements are made:

		- `&` becomes `&amp`;
		- `<` becomes `&lt`;
		- `>` becomes `&gt`;

		If `quotes` is true, the following characters are also replaced:

		- `"` becomes `&quot`;
		- `'` becomes `&#039`;
	**/
	public static function htmlEscape(s:String, quotes = false):String {
		var buf = new StringBuf();
		for (code in #if neko iterator(s) #else new haxe.iterators.StringIteratorUnicode(s) #end) {
			switch (code) {
				case '&'.code:
					buf.add("&amp;");
				case '<'.code:
					buf.add("&lt;");
				case '>'.code:
					buf.add("&gt;");
				case '"'.code if (quotes):
					buf.add("&quot;");
				case '\''.code if (quotes):
					buf.add("&#039;");
				case _:
					buf.addChar(code);
			}
		}
		return buf.toString();
	}

	/**
		Unescapes HTML special characters of the string `s`.

		This is the inverse operation to htmlEscape, i.e. the following always
		holds: `htmlUnescape(htmlEscape(s)) == s`

		The replacements follow:

		- `&amp;` becomes `&`
		- `&lt;` becomes `<`
		- `&gt;` becomes `>`
		- `&quot;` becomes `"`
		- `&#039;` becomes `'`
	**/
	public static function htmlUnescape(s:String):String {
		return s.split("&gt;")
			.join(">")
			.split("&lt;")
			.join("<")
			.split("&quot;")
			.join('"')
			.split("&#039;")
			.join("'")
			.split("&amp;")
			.join("&");
	}

	/**
		Returns `true` if `s` contains `value` and  `false` otherwise.

		When `value` is `null`, the result is unspecified.
	**/
	public static inline function contains(s:String, value:String):Bool {
		#if (js && js_es >= 6)
		return (cast s).includes(value);
		#else
		return s.indexOf(value) != -1;
		#end
	}

	/**
		Tells if the string `s` starts with the string `start`.

		If `start` is `null`, the result is unspecified.

		If `start` is the empty String `""`, the result is true.
	**/
	public static #if (java || python || (js && js_es >= 6)) inline #end function startsWith(s:String, start:String):Bool {
		#if java
		return (cast s : java.NativeString).startsWith(start);
		#elseif hl
		return @:privateAccess (s.length >= start.length && s.bytes.compare(0, start.bytes, 0, start.length << 1) == 0);
		#elseif python
		return python.NativeStringTools.startswith(s, start);
		#elseif (js && js_es >= 6)
		return (cast s).startsWith(start);
		#elseif lua
		return untyped __lua__("{0}:sub(1, #{1}) == {1}", s, start);
		#else
		return (s.length >= start.length && s.lastIndexOf(start, 0) == 0);
		#end
	}

	/**
		Tells if the string `s` ends with the string `end`.

		If `end` is `null`, the result is unspecified.

		If `end` is the empty String `""`, the result is true.
	**/
	public static #if (java || python || (js && js_es >= 6)) inline #end function endsWith(s:String, end:String):Bool {
		#if java
		return (cast s : java.NativeString).endsWith(end);
		#elseif hl
		var elen = end.length;
		var slen = s.length;
		return @:privateAccess (slen >= elen && s.bytes.compare((slen - elen) << 1, end.bytes, 0, elen << 1) == 0);
		#elseif python
		return python.NativeStringTools.endswith(s, end);
		#elseif (js && js_es >= 6)
		return (cast s).endsWith(end);
		#elseif lua
		return end == "" || untyped __lua__("{0}:sub(-#{1}) == {1}", s, end);
		#else
		var elen = end.length;
		var slen = s.length;
		return (slen >= elen && s.indexOf(end, (slen - elen)) == (slen - elen));
		#end
	}

	/**
		Tells if the character in the string `s` at position `pos` is a space.

		A character is considered to be a space character if its character code
		is 9,10,11,12,13 or 32.

		If `s` is the empty String `""`, or if pos is not a valid position within
		`s`, the result is false.
	**/
	public static function isSpace(s:String, pos:Int):Bool {
		#if (python || lua)
		if (s.length == 0 || pos < 0 || pos >= s.length)
			return false;
		#end
		var c = s.charCodeAt(pos);
		return (c > 8 && c < 14) || c == 32;
	}

	/**
		Removes leading space characters of `s`.

		This function internally calls `isSpace()` to decide which characters to
		remove.

		If `s` is the empty String `""` or consists only of space characters, the
		result is the empty String `""`.
	**/
	public inline static function ltrim(s:String):String {
		var l = s.length;
		var r = 0;
		while (r < l && isSpace(s, r)) {
			r++;
		}
		if (r > 0)
			return s.substr(r, l - r);
		else
			return s;
	}

	/**
		Removes trailing space characters of `s`.

		This function internally calls `isSpace()` to decide which characters to
		remove.

		If `s` is the empty String `""` or consists only of space characters, the
		result is the empty String `""`.
	**/
	public inline static function rtrim(s:String):String {
		var l = s.length;
		var r = 0;
		while (r < l && isSpace(s, l - r - 1)) {
			r++;
		}
		if (r > 0) {
			return s.substr(0, l - r);
		} else {
			return s;
		}
	}

	/**
		Removes leading and trailing space characters of `s`.

		This is a convenience function for `ltrim(rtrim(s))`.
	**/
	public #if java inline #end static function trim(s:String):String {
		#if java
		return (cast s : java.NativeString).trim();
		#else
		return ltrim(rtrim(s));
		#end
	}

	/**
		Concatenates `c` to `s` until `s.length` is at least `l`.

		If `c` is the empty String `""` or if `l` does not exceed `s.length`,
		`s` is returned unchanged.

		If `c.length` is 1, the resulting String length is exactly `l`.

		Otherwise the length may exceed `l`.

		If `c` is null, the result is unspecified.
	**/
	public static function lpad(s:String, c:String, l:Int):String {
		if (c.length <= 0)
			return s;

		var buf = new StringBuf();
		l -= s.length;
		while (buf.length < l) {
			buf.add(c);
		}
		buf.add(s);
		return buf.toString();
	}

	/**
		Appends `c` to `s` until `s.length` is at least `l`.

		If `c` is the empty String `""` or if `l` does not exceed `s.length`,
		`s` is returned unchanged.

		If `c.length` is 1, the resulting String length is exactly `l`.

		Otherwise the length may exceed `l`.

		If `c` is null, the result is unspecified.
	**/
	public static function rpad(s:String, c:String, l:Int):String {
		if (c.length <= 0)
			return s;

		var buf = new StringBuf();
		buf.add(s);
		while (buf.length < l) {
			buf.add(c);
		}
		return buf.toString();
	}

	/**
		Replace all occurrences of the String `sub` in the String `s` by the
		String `by`.

		If `sub` is the empty String `""`, `by` is inserted after each character
		of `s` except the last one. If `by` is also the empty String `""`, `s`
		remains unchanged.

		If `sub` or `by` are null, the result is unspecified.
	**/
	public static function replace(s:String, sub:String, by:String):String {
		#if java
		if (sub.length == 0)
			return s.split(sub).join(by);
		else
			return (cast s : java.NativeString).replace(sub, by);
		#else
		return s.split(sub).join(by);
		#end
	}

	/**
		Encodes `n` into a hexadecimal representation.

		If `digits` is specified, the resulting String is padded with "0" until
		its `length` equals `digits`.
	**/
	public static function hex(n:Int, ?digits:Int) {
		#if flash
		var n:UInt = n;
		var s:String = untyped n.toString(16);
		s = s.toUpperCase();
		#else
		var s = "";
		var hexChars = "0123456789ABCDEF";
		do {
			s = hexChars.charAt(n & 15) + s;
			n >>>= 4;
		} while (n > 0);
		#end
		#if python
		if (digits != null && s.length < digits) {
			var diff = digits - s.length;
			for (_ in 0...diff) {
				s = "0" + s;
			}
		}
		#else
		if (digits != null)
			while (s.length < digits)
				s = "0" + s;
		#end
		return s;
	}

	/**
		Returns the character code at position `index` of String `s`, or an
		end-of-file indicator at if `position` equals `s.length`.

		This method is faster than `String.charCodeAt()` on some platforms, but
		the result is unspecified if `index` is negative or greater than
		`s.length`.

		End of file status can be checked by calling `StringTools.isEof()` with
		the returned value as argument.

		This operation is not guaranteed to work if `s` contains the `\0`
		character.
	**/
	public static #if !eval inline #end function fastCodeAt(s:String, index:Int):Int {
		return untyped s.unicode_at(index);
	}

	/**
		Returns the character code at position `index` of String `s`, or an
		end-of-file indicator at if `position` equals `s.length`.

		This method is faster than `String.charCodeAt()` on some platforms, but
		the result is unspecified if `index` is negative or greater than
		`s.length`.

		This operation is not guaranteed to work if `s` contains the `\0`
		character.
	**/
	public static #if !eval inline #end function unsafeCodeAt(s:String, index:Int):Int {
		return untyped s.unicode_at(index);
	}

	/**
		Returns an iterator of the char codes.

		Note that char codes may differ across platforms because of different
		internal encoding of strings in different runtimes.
		For the consistent cross-platform UTF8 char codes see `haxe.iterators.StringIteratorUnicode`.
	**/
	public static inline function iterator(s:String):StringIterator {
		return new StringIterator(s);
	}

	/**
		Returns an iterator of the char indexes and codes.

		Note that char codes may differ across platforms because of different
		internal encoding of strings in different of runtimes.
		For the consistent cross-platform UTF8 char codes see `haxe.iterators.StringKeyValueIteratorUnicode`.
	**/
	public static inline function keyValueIterator(s:String):StringKeyValueIterator {
		return new StringKeyValueIterator(s);
	}

	/**
		Tells if `c` represents the end-of-file (EOF) character.
	**/
	@:noUsing public static inline function isEof(c:Int):Bool {
		#if (flash || cpp || hl)
		return c == 0;
		#elseif js
		return c != c; // fast NaN
		#elseif (neko || lua || eval)
		return c == null;
		#elseif (java || python)
		return c == -1;
		#else
		return false;
		#end
	}

	/**
		Returns a String that can be used as a single command line argument
		on Unix.
		The input will be quoted, or escaped if necessary.
	**/
	@:noCompletion
	@:deprecated('StringTools.quoteUnixArg() is deprecated. Use haxe.SysTools.quoteUnixArg() instead.')
	public static function quoteUnixArg(argument:String):String {
		return inline haxe.SysTools.quoteUnixArg(argument);
	}

	/**
		Character codes of the characters that will be escaped by `quoteWinArg(_, true)`.
	**/
	@:noCompletion
	@:deprecated('StringTools.winMetaCharacters is deprecated. Use haxe.SysTools.winMetaCharacters instead.')
	public static var winMetaCharacters:Array<Int> = cast haxe.SysTools.winMetaCharacters;

	/**
		Returns a String that can be used as a single command line argument
		on Windows.
		The input will be quoted, or escaped if necessary, such that the output
		will be parsed as a single argument using the rule specified in
		http://msdn.microsoft.com/en-us/library/ms880421

		Examples:
		```haxe
		quoteWinArg("abc") == "abc";
		quoteWinArg("ab c") == '"ab c"';
		```
	**/
	@:noCompletion
	@:deprecated('StringTools.quoteWinArg() is deprecated. Use haxe.SysTools.quoteWinArg() instead.')
	public static function quoteWinArg(argument:String, escapeMetaCharacters:Bool):String {
		return inline haxe.SysTools.quoteWinArg(argument, escapeMetaCharacters);
	}

	#if java
	private static inline function _charAt(str:String, idx:Int):jvm.Char16
		return (cast str : java.NativeString).charAt(idx);
	#end

	#if neko
	private static var _urlEncode = neko.Lib.load("std", "url_encode", 1);
	private static var _urlDecode = neko.Lib.load("std", "url_decode", 1);
	#end

	#if utf16
	static inline var MIN_SURROGATE_CODE_POINT = 65536;

	static inline function utf16CodePointAt(s:String, index:Int):Int {
		var c = StringTools.fastCodeAt(s, index);
		if (c >= 0xD800 && c <= 0xDBFF) {
			c = ((c - 0xD7C0) << 10) | (StringTools.fastCodeAt(s, index + 1) & 0x3FF);
		}
		return c;
	}
	#end
}