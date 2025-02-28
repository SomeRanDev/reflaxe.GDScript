# Exporting Properties

`@:export` can be used like the `@export` metadata from GDScript:
```haxe
class MyNode extends godot.Node {
	@:export
	var customNumber: Int = 20;
}
```

 This would be converted to:
```gdscript
extends Node;
class_name MyNode;

@export
var customNumber: int = 20;
```
