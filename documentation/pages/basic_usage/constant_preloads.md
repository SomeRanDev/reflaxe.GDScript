# Constant Preloads

`@:const` creates a `const` variable in GDScript.
```haxe
class MyNode extends godot.Node {
	@:const
	final MAX_JUMPS = 4;
}
```

 This would be converted to:
```gdscript
extends Node;
class_name MyNode;

const MAX_JUMPS: int = 4;
```

## Preloading Resources

A common pattern in GDScript is to `preload` resources into a `const` variable. The `@:const` metadata provides a helper feature to achieve this:
```haxe
class MyNode extends godot.Node {
	@:const(preload = "res://scenes/bullet.tscn")
	final BULLET_SCENE: PackedScene;
}
```

 This would be converted to:
```gdscript
extends Node;
class_name MyNode;

const BULLET_SCENE: PackedScene = preload("res://scenes/bullet.tscn");
```
