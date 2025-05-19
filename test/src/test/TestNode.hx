package test;

extern class Node {
	function _ready(): Void;
}

class TestNode extends Node {
	@:export var dictionary = new gdscript.Dictionary<String, String>();

	override function _ready() {
		trace(dictionary); // Check that this matches what's placed in editor.
	}
}
