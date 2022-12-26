# Haxe: GDScript Target
Compile Haxe to GDScript 2.0 like any other Haxe target. Made using [Reflaxe](https://github.com/RobertBorghese/reflaxe).

How to install:

```hxml
# In your compile.hxml file...

# Enable the library
-lib gdscript

# Set output folder to "./output"
-D gdscript-output=output
```

Check out `/test` for a sample project that tests all Haxe syntax and every Haxe std class that's been ported so far. Tested successfully on Godot 4 Beta 8 (*Beta 10 has a bug that makes the tests fail but it's not this project's fault I swear.*)

## How it outputs

- [x] As GDScript outputs one file per class, each class, regardless of module, receives its own file.

- [x] A custom version of the Haxe standard library is made for GDScript (check out `std/gdscript/_std`)

- [ ] Bindings to the Godot classes/functions (check out `std/godot`)

- [x] If GDScript is being generated, conditional compilation can be used with the `gdscript` define.
```haxe
#if gdscript
doSomethingOnlyForGDScript();
#end
```

- [x] GDScript can be injected directly using:
```haxe
untyped __gdscript__("print(123)");
```

- [ ] GDScript meta can be defined using `@:meta`, though there should be defined metadata for each existing attribute in GDScript.
```haxe
@:meta(onready) var someVal = get_node("myNode")
```

- [ ] (Unfinished) Haxe enum support
