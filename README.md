# Haxe: GDScript Target
Compile Haxe to GDScript 2.0 like any other Haxe target. Made using [Reflaxe](https://github.com/RobertBorghese/reflaxe).

This project is incomplete and experimental. No guarantee it will be completed.

How to install:

```hxml
# In your compile.hxml file...

# Enable the library
# This will not work currently as this lib hasn't been added to haxelib
-lib gdscript-target

# Set output folder to "./output"
-D gdscript-output=output
```

## How it outputs

* As GDScript outputs one file per class, each class, regardless of module, receives its own file.

* A custom version of the Haxe standard library is made for GDScript (check out `std/gdscript/_std`)

* If GDScript is being generated, conditional compilation can be used with the `gdscript` define.
```haxe
#if gdscript
doSomethingOnlyForGDScript();
#end
```

* GDScript can be injected directly using:
```haxe
untyped __gdscript__("print(123)");
```

* GDScript meta can be defined using `@:meta`, though there should be defined metadata for each existing attribute in GDScript.
```haxe
@:meta(onready) var someVal = get_node("myNode")
```
