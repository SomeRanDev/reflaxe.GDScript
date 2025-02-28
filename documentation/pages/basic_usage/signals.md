# Signals

A signal can be added using the `@:signal` metadata:
```haxe
import godot.*;

class MyNode extends CharacterBody2D {
	// Any code in this function will be ignored
	@:signal
	function onHitGround(speed: Float) {}
}
```

The `emit_signal` function from the generated API only supports a `String` parameter, but you can use `emit_signal` from the Reflaxe/GDScript API class: `gdscript.ObjectEx`.
```haxe
import godot.*;
import gdscript.ObjectEx;

class MyNode extends CharacterBody2D {
	@:signal
	function onHitGround(speed: Float) {}

	public override function _physics_process(delta: Float) {
		var hitGround = false;

		// Do some processing...

		if(hitGround) {
			ObjectEx.emit_signal("onHitGround", velocity.length());
		}
	}
}
```
