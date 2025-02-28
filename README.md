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

| Topic                                                                           | Description                                        |
| ------------------------------------------------------------------------------- | -------------------------------------------------- |
| [Installation](#installation)                                                   | How to install and use this project.               |
| [GDScript Output as a Plugin](#loading-your-gdscript-output-as-a-plugin)        | How to load your code using the plugin workflow.   |
| [Godot Bindings](#godot-bindings)                                               | How to setup the Godot bindings.                   |
| [Goals](#goals)                                                                 | The checklist for the goals of this project        |

&nbsp;

# Installation

| #   | What to do                                           | What to write                            |
| --- | ---------------------------------------------------- | ---------------------------------------- |
| 1   | Install via haxelib (DON'T FORGET `1.0.0-beta!`)      | <pre>haxelib install gdscript 1.0.0-beta</pre>   |
| 2   | Add the lib to your `.hxml` file or compile command.  | <pre lang="hxml">-lib gdscript</pre>  |
| 3   | Set the output folder for the compiled GDScript.      | <pre lang="hxml">-D gdscript-output=out</pre> |
| 4   | Optionally, generate your code as a Godot plugin.     | <pre lang="hxml">-D generate_godot_plugin</pre> |

&nbsp;

# Loading Your GDScript Output as a Plugin

If you choose to output a Godot plugin, the setup process is very easy. Generate the GDScript code into a folder in your "addons" folder for your Godot project. For example:
```
-D gdscript-output=MY_GODOT_PROJECT/addons/haxe_output
```

To enable the plugin, go to `Project (top-left) > Project Settings > Plugins (tab)` and click the checkbox next to your plugin's name.

&nbsp;

# Godot Bindings

Reflaxe/GDScript does not come with bindings to Godot types by default since the version of Godot is different for every person. However, generating the bindings is SUPER DUPER easy.

First, install the [Haxe Godot Bindings Generator](https://github.com/SomeRanDev/Haxe-GodotBindingsGenerator) library:
```
haxelib git godot-api-generator https://github.com/SomeRanDev/Haxe-GodotBindingsGenerator
```

Next, run this command to generate:
```
haxelib run godot-api-generator
```

This will generate all the Godot bindings as `.hx` Haxe source code files in a local folder named "godot".

### Godot Executable Configuration
When you run the command, you will be asked for the path to your Godot engine executable, so be sure to find it first! If you do not want to enter it manually, you can assign it to the `GODOT_PATH` environment variable before running the command.

&nbsp;

## How Does It Work?

- As GDScript outputs one file per class, each class, regardless of module, receives its own file.
- A custom version of the Haxe standard library is made for GDScript (check out `std/gdscript/_std`)
- Bindings to the Godot classes/functions are generated using [Godot Bindings Generator for Haxe](https://github.com/SomeRanDev/Haxe-GodotBindingsGenerator)

### Inject GDScript
- GDScript can be injected directly using:
```haxe
// Haxe
untyped __gdscript__("print(123)");

//GDScript
print(123);
```

### GDScript Annotations
- GDScript meta can be defined using `@:meta`, though there should be defined metadata for each existing attribute in GDScript.
```haxe
// Haxe
@:meta(onready) var someVal = get_node("myNode")

// GDScript
@onready
var someVal = get_node("myNode")
```

### Enum Support
- Haxe enums are converted into simple dictionaries in GDScript.
```haxe
// Haxe
var myEnum = SomeEnumCase(123, "Hello!");

// GDScript
var myEnum = { "_index": 2, "num": 123, "text": "Hello!" }
```
