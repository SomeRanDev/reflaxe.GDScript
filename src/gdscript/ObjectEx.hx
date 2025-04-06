package gdscript;

import haxe.macro.Context;
import haxe.macro.Expr;

class ObjectEx {
	@:native("emit_signal")
	public static macro function emit_signal(args: Array<Expr>): Expr {
		final injectArgs = [];
		for(i in 0...args.length) {
			injectArgs.push('{$i}');
		}
		final injectString = 'emit_signal(${injectArgs.join(", ")})';
		return {
			expr: ECall(macro untyped __gdscript__, [macro $v{injectString}].concat(args)),
			pos: Context.currentPos()
		};
	}
}
