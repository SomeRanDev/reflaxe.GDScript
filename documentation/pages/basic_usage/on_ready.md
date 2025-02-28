# On Ready

`@:onready` can be used like the `@on_ready` metadata from GDScript:
```haxe
class MyNode extends godot.Node {
	@:onready
	var customNumber: Int = 20;
}
```

 This would be converted to:
```gdscript
extends Node;
class_name MyNode;

@onready
var customNumber: int = 20;
```

## Loading Nodes

`@:onready` has a helper feature that can be used to load nodes from a path. Simply pass a `String` assignment to `node`:
```haxe
class MyNode extends godot.Node {
	@:onready(node = "Label")
	var label: Label;
}
```

 This would be converted to:
```gdscript
extends Node;
class_name MyNode;

@onready
var label: Label = $Label;
```
