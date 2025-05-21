# `gdscript.Syntax` class

The `Syntax` class has a couple utilities.

## `is` Operator

This allows for direct generation of `is` expressions.

For example:
```haxe
if(gdscript.Syntax.is(sprite, Sprite2D)) {
	cast(sprite, Sprite2D).centered = true;
}
```

Converts to:
```gdscript
if sprite is Sprite2D:
	(sprite as Sprite2D).centered = true;
```

## Node Path Using `$`

To generate an expression for obtaining a node via `$`, `gdscript.Syntax.dollar` can be used. The parameter can either be an identifier or String.

For example:
```haxe
var a: godot.Label = gdscript.Syntax.dollar(MyLabel);
var b: godot.Label = gdscript.Syntax.dollar("Path/To/OtherLabel"); // must use String for slashes
```

Converts to:
```gdscript
var a: Label = $MyLabel;
var b: Label = $Path/To/OtherLabel;
```

## Accessing Unique Name Nodes

The `%` syntax can be used with `gdscript.Syntax.percent`.

For example:
```haxe
var a: godot.Sprite2D = gdscript.Syntax.percent(MySprite);
```

Converts to:
```gdscript
var a: Sprite2D = %MySprite;
```

## Generating Variables Without Assignments

Sometimes you may want to use `final` in Haxe since you don't want to reassign it, but the initial assignment doesn't happen within the Haxe code. For example, a variable that uses `@:export` or `@:const(preload = "...")`.

Simply assign `gdscript.Syntax.NoAssign` to bypass the error in the Haxe compiler, but assign nothing in the generated GDScript.

For example:
```haxe
@:export final other_sprite: godot.Sprite2D = gdscript.Syntax.NoAssign;
```

Converts to:
```gdscript
@export var other_sprite: Sprite2D;
```
