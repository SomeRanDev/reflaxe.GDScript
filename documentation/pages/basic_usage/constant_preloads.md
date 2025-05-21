# Constant Preloads

`@:const` creates a `const` variable in GDScript.
```haxe
class MyNode extends godot.Node {
	@:const
	static final MAX_JUMPS = 4;
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
	// Use `gdscript.Syntax.NoAssign` since Haxe requires us to assign something to `final`.
	@:const(preload = "res://scenes/bullet.tscn")
	static final BULLET_SCENE: PackedScene = gdscript.Syntax.NoAssign;
}
```

 This would be converted to:
```gdscript
extends Node;
class_name MyNode;

const BULLET_SCENE: PackedScene = preload("res://scenes/bullet.tscn");
```
