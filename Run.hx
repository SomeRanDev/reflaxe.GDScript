package;

import sys.FileSystem;
import sys.io.Process;

function main() {
	// Ensure we use current directory of haxelib run call.
	final cwd = switch(Sys.args()) {
		case [cwd]: {
			cwd;
		}
		case args: {
			args[args.length - 1];
		}
	}
	Sys.setCwd(cwd);

	// We start!!
	Sys.println("Generating Godot bindings...");

	// Check for godot executable
	var godotVersion = "";
	var godotPath: Null<String> = Sys.getEnv("GODOT_PATH");
	if(godotPath == null) {
		godotPath = try {
			final process = new Process("godot", ["--version"]);
			if(process.exitCode(true) == 0) {
				"godot";
			} else {
				null;
			}
		} catch(e) {
			null;
		}
	}

	// Request path to godot executable if not found
	if(godotPath == null) {
		Sys.println("'godot' could not be found, please enter the path to the executable:");
		Sys.print("> ");

		while(true) {
			final path = Sys.stdin().readLine().toString();

			godotPath = if(FileSystem.exists(path) && !FileSystem.isDirectory(path)) {
				try {
					final process = new Process(path, ["--version"]);
					if(process.exitCode(true) == 0) {
						godotVersion = process.stdout.readAll().toString();
						path;
					} else {
						null;
					}
					
				} catch(e) {
					null;
				}
			} else {
				null;
			}

			if(godotPath == null) {
				Sys.println("'" + path + "' could not be found, please try again:");
				Sys.print("> ");
			} else {
				break;
			}
		}
	}

	// Generate `extension_api.json`
	Sys.println('>> ${godotPath} --dump-extension-api-with-docs --headless');
	final process = new Process(godotPath, ["--dump-extension-api-with-docs", "--headless"]);
	process.exitCode(true);

	// Install `godot-api-generator`
	Sys.println('>> haxelib install godot-api-generator');
	final process = new Process("haxelib", ["install", "godot-api-generator"]);
	if(process.exitCode(true) != 0) {
		Sys.println("Could not install 'godot-api-generator' from haxelib.\n");
		Sys.println(process.stdout.readAll().toString());
		Sys.println(process.stderr.readAll().toString());
		return;
	}

	// Generate bindings using `godot-api-generator`
	Sys.println('>> haxelib run godot-api-generator extension_api.json godot');
	final process = new Process("haxelib", ["run", "godot-api-generator", "./extension_api.json", "./godot"]);
	if(process.exitCode(true) != 0) {
		Sys.println("Could not run 'godot-api-generator'.\n");
		Sys.println(process.stdout.readAll().toString());
		Sys.println(process.stderr.readAll().toString());
		return;
	}

	// We done!!
	Sys.println("Done!");
}
