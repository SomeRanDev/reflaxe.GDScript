package gdcompiler.config;

enum abstract Meta(String) from String to String {
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
}
