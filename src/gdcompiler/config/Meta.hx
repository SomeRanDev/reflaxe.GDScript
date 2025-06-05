package gdcompiler.config;

enum abstract Meta(String) from String to String {
	/**
		@:await

		`await`s an expression.

		---
		
		The conversion is extremely simple; it converts `@:await` into await.
		```haxe
		// This
		final waited_for_value = @:await auth.login(password);
		```
		```gdscript
		# Becomes this
		var waited_for_value = await auth.login(password);
		```
	**/
	var Await = ":await";

	/**
		@:onready

		Marks a variable as `@onready`.

		---
		
		To assign this a specific GDScript expression, use `val = "something"`:
		```haxe
		// This
		@:onready(val = "my.custom.expression()") var my_field: String;
		```
		```gdscript
		# Becomes this
		@onready var my_field: String = my.custom.expression();
		```

		To assign to a child node path, use `node = "path"`:
		```haxe
		// This
		@:onready(node = "Container/Label") var my_label: godot.Label;
		```
		```gdscript
		# Becomes this
		@onready var my_label: Label = $Container/Label;
		```
	**/
	var OnReady = ":onready";

	/**
		@:const

		Creates a `const` variable.
	**/
	var Const = ":const";

	/**
		@:signal

		Treats the class function as a signal declaration.
	**/
	var Signal = ":signal";

	/**
		@:icon(path: String)

		Use on a class with `godot.Node` or `godot.Resource` in its class hierarchy.
		This defines a custom path for the type's icon.
	**/
	var Icon = ":icon";

	/**
		@:get(functionIdentifier: Expr)

		Adds a `get` implementation to the variable.

		The argument must be the identifier to a function with no arguments and
		returns the same type as the variable.
	**/
	var Get = ":get";

	/**
		@:set(functionIdentifier: Expr)

		Adds a `set` implementation to the variable.

		The argument must be the identifier to a function with no return and
		one argument the same type as the variable.
	**/
	var Set = ":set";

	/**
		@:outputFile(path: String)

		Explicitly sets the output file path for a class.
	**/
	var OutputFile = ":outputFile";

	/**
		@:dontAddToPlugin

		If added to a class, the class will not be loaded by the generated plugin.
	**/
	var DontAddToPlugin = ":dontAddToPlugin";

	/**
		@:dont_compile

		If used on a type declaration, that type is never compiled to GDScript.

		```haxe
		final a: gdscript.Untyped = 123;
		```

		```gdscript
		# Normally this would be:
		# var a: int = 123;

		var a = 123;
		```
	**/
	var DontCompile = ":dont_compile";

	/**
		@:uncompilable

		If Reflaxe/GDScript attempts to compile a field with this metadata,
		it will throw an error.
		
		Used to ensure fields intended to be replaced at compile-time aren't compiled.
	**/
	var Uncompilable = ":uncompilable";

	/**
		@:wrapper(selfName: String = "_self")

		If added to a class, that class will be treated as a wrapper class. This means
		instead of using `self`, all instance functions will be provided a `self` replacement
		argument to use as `self`.

		Class variables will still be implemented entirely in GDScript.
	**/
	var Wrapper = ":wrapper";

	/**
		@:wrapPublicOnly

		If added to a class with `@:wrapper`, this will make it so only public function are
		"wrapped". Private functions will be generated and called entirely within
		GDScript.
	**/
	var WrapPublicOnly = ":wrapPublicOnly";

	/**
		@:bypass_wrapper

		If used on a field, the effects of `@:wrapper` will be ignored when accessing it.
	**/
	var BypassWrapper = ":bypass_wrapper";

	/**
		@:nativeName(name: String)

		Use instead of `@:native`.
	**/
	var NativeName = ":nativeName";

	/**
		@:keepName

		Keeps the name of the field no matter what.
	**/
	var KeepName = ":keepName";
}
