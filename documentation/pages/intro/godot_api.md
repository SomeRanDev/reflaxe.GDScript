# Godot API

Okay!! Now let's make a custom Node! ... oh wait, there's no `Node2D` or `Node3D` class to extend from?

As the Godot API can change depending on the version, no specific API is packaged with Reflaxe/GDScript. Instead, you need to generate your own Haxe bindings for Godot.

## Generating the Bindings

First, install the [Haxe Godot Bindings Generator](https://github.com/SomeRanDev/Haxe-GodotBindingsGenerator) library:
```
haxelib git godot-api-generator https://github.com/SomeRanDev/Haxe-GodotBindingsGenerator
```

Next, enter your Haxe source code folder:
```
cd src
```

Finally, run this command to generate:
```
haxelib run godot-api-generator
```

This will generate all the Godot bindings as `.hx` Haxe source code files in a local folder named "godot". The files are generated with the expectation they will be in a `godot` package, so this should be perfect.

### Godot Executable Configuration
When you run the command, you will be asked for the path to your Godot engine executable, so be sure to find it first! If you do not want to enter it manually, you can assign it to the `GODOT_PATH` environment variable before running the command.

## Extending from a Node
You can now extend from `Node` like this:
```haxe
class MyNode extends godot.Node {
	public override function _ready() {
		trace("MyNode is ready!");
	}
}
```

## Easy Access
If you'd like easy access to all of the Godot API, just `import godot.*`.
```haxe
import godot.*;

class MyNode extends Node {
	public override function _ready() {
		trace("MyNode is ready!");
	}
}
```
