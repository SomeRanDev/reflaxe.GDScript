<img src="img/Logo.png" /> 

<a href="https://discord.com/channels/162395145352904705/1052688097592225904"><img src="https://discordapp.com/api/guilds/162395145352904705/widget.png?style=shield" alt="Reflaxe Thread"/></a>

_Compile Haxe to GDScript 2.0 like any other Haxe target. Made using [Reflaxe](https://github.com/RobertBorghese/reflaxe)._

&nbsp;

**Haxe Code**

```haxe
function main() {
    trace("Hello world!");

    final num = if(Math.random() < 0.5) {
        123;
    } else {
        321;
    }
}
```

**Reflaxe/GDScript Output**

```gdscript
class_name Main

func main():
    HxStaticVars._Log.trace.call("Hello world!", { "fileName": "src/Main.hx", "lineNumber": 2, "className": "Main", "methodName": "main" })

    var num
    if (randf() < 0.5):
        num = 123
    else:
        num = 321
```

&nbsp;

# Table of Contents

| Topic                                  | Description                                        |
| -------------------------------------- | -------------------------------------------------- |
| [Installation](#installation)          | How to install and use this project.               |
| [Godot Bindings](#godot-bindings)      | How to setup the Godot bindings.                   |
| [Goals](#goals)                        | The checklist for the goals of this project        |

&nbsp;

# Installation

This project is currently in development, so install using `haxelib git`:

| #   | What to do                                           | What to write                            |
| --- | ---------------------------------------------------- | ---------------------------------------- |
| 1   | Install via git.                                     | <pre>haxelib git gdscript https://github.com/SomeRanDev/reflaxe.GDScript nightly</pre>   |
| 2   | Add the lib to your `.hxml` file or compile command. | <pre lang="hxml">-lib gdscript</pre>  |
| 3   | Set the output folder for the compiled C++.          | <pre lang="hxml">-D gdscript-output=out</pre> |

&nbsp;

# Godot Bindings

Reflaxe/GDScript does not come with bindings to Godot types by default since the version of Godot is different for every person. However, generating the bindings is SUPER DUPER easy.

Simply run this command after installing this library:
```
haxelib run reflaxe.GDScript
```

This will generate all the Godot bindings as `.hx` Haxe source code files in a local folder named "godot".

### Godot Executable Configuration
When you run the command, you will be asked for the path to your Godot engine executable, so be sure to find it first! If you do not want to enter it manually, you can assign it to the `GODOT_PATH` environment variable before running the command.

&nbsp;

## Goals

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

- [x] GDScript meta can be defined using `@:meta`, though there should be defined metadata for each existing attribute in GDScript.
```haxe
@:meta(onready) var someVal = get_node("myNode")
```

- [x] Haxe enum support.
```haxe
var myEnum = SomeEnumCase(123, "Hello!");
```
```gdscript
var myEnum = { "_index": 2, "num": 123, "text": "Hello!" }
```
