# First Node

Here's the basic outline for an extended `Node` in Haxe with Reflaxe/GDScript:
```haxe
import godot.*;

class MyNode extends Node {
	public override function _ready() {
		// on ready...
	}

	public override function _process(delta: Float) {
		// on update...
	}
}
```

You can override any functions marked "virtual" in Godot's documentation like this:

```haxe
import godot.*;

class MyNode extends Node {
	public override function _input(event: InputEvent) {
		// on ready...
	}

	public override function _physics_process(delta: Float) {
		// on physics update...
	}
}
```
