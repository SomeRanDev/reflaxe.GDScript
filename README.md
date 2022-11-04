# Haxe: Compile To GDScript
Compile Haxe to GDScript 2.0 like any other Haxe target.

This project is incomplete and experimental. No guarantee it will be completed.

May not work at the moment, but this is how I plan for it to work:

```hxml
# Enable the library
-lib gdscript-compiler

# Set output folder to "./output"
-D gdscript-output=output

# We do not want to output any other target
--no-output
```

## How it outputs

* As GDScript outputs one file per class, each class, regardless of module, receives its own file.

* The next issue is namespaces. The only option really is to generate class names that use underscores to differentiate the Haxe class path within the GDScript class name.

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
