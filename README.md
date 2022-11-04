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
