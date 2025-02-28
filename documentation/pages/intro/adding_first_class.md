# Adding First Class

Let's go ahead and make a class in Haxe to compile into GDScript!

```haxe
// MyClass.hx
package;

class MyClass {
	public function new(myNumber: Int) {
		trace('Received number: $myNumber');
	}
}
```
```hxml
# Compile.hxml
-p src
-lib gdscript
-D gdscript-output=out
```

WAIT! There's no main function? Godot doesn't use a main, it just takes GDScript files created by the user. But because of Haxe's DCE, our `MyClass` class won't be compiled.

## Choosing What to Compile

Since GDScript does not rely on a `main` function, you need to tell Haxe what files it needs to compile for your project. This can be done by listing modules in your `.hxml` file.

```haxe
// MyClass.hx
package;

class MyClass {
	public function new(myNumber: Int) {
		trace('Received number: $myNumber');
	}
}
```
```hxml
# Compile.hxml
-p src
-lib gdscript
-D gdscript-output=out

MyClass
```

### Just Compile Everything!

This could get annoying when adding new files, so instead you can also place all of your "to-be-compiled" classes in a package and write that.
```haxe
// game/MyClass.hx
package game;

class MyClass {
	public function new(myNumber: Int) {
		trace('Received number: $myNumber');
	}
}
```
```hxml
# Compile.hxml
-p src
-lib gdscript
-D gdscript-output=out

game # Every class in `game` will now be compiled
```

### Output

Aaaand now you should receive some output like this:
```gdscript
class_name MyClass;

func _init(myNumber: int):
	print("game/MyClass.hx:6: Received number: " + myNumber);
```
