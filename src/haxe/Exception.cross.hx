package haxe;

class Exception {
	/**
		Exception message.
	**/
	public var message(get,never): String;
	var _message: String;
	private function get_message(): String return _message;

	/**
		The call stack at the moment of the exception creation.
	**/
	public var stack(get,never): CallStack;
	private function get_stack(): CallStack {
		return [];
	}

	/**
		Contains an exception, which was passed to `previous` constructor argument.
	**/
	public var previous(get, never): Null<Exception>;
	var _previous: Null<Exception>;
	private function get_previous(): Null<Exception> return _previous;

	/**
		Native exception, which caused this exception.
	**/
	public var native(get,never): Any;
	var _native: Any;
	final private function get_native(): Any return _native;

	/**
		Used internally for wildcard catches like `catch(e:Exception)`.
	**/
	static private function caught(value: Any): Exception {
		return new haxe.Exception(Std.string(value));
	}

	/**
		Used internally for wrapping non-throwable values for `throw` expressions.
	**/
	static private function thrown(value: Any): Any {
		return value;
	}

	/**
		Create a new Exception instance.

		The `previous` argument could be used for exception chaining.

		The `native` argument is for internal usage only.
		There is no need to provide `native` argument manually and no need to keep it
		upon extending `haxe.Exception` unless you know what you're doing.
	**/
	public function new(message: String, ?previous: Exception, ?native: Any):Void {
		_message = message;
		_previous = previous;
		_native = native;
	}

	/**
		Extract an originally thrown value.

		Used internally for catching non-native exceptions.
		Do _not_ override unless you know what you are doing.
	**/
	private function unwrap():Any {
		return _native;
	}

	/**
		Returns exception message.
	**/
	public function toString():String {
		return _message;
	}

	/**
		Detailed exception description.

		Includes message, stack and the chain of previous exceptions (if set).
	**/
	public function details():String {
		return _message;
	}

	/**
		If this field is defined in a target implementation, then a call to this
		field will be generated automatically in every constructor of derived classes
		to make exception stacks point to derived constructor invocations instead of
		`super` calls.
	**/
	// @:noCompletion @:ifFeature("haxe.Exception.stack") private function __shiftStack():Void;
}
