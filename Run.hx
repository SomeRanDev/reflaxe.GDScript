package;

import sys.FileSystem;
import sys.io.Process;

function main() {
	final libPath = switch(Sys.args()) {
		case [libPath]: {
			libPath;
		}
		case args: {
			args[args.length - 1];
		}
	}

	Sys.println("Generating Godot bindings...");

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

	final process = new Process(godotPath, ["--dump-extension-api-with-docs", "--headless"]);
	process.exitCode(true);

	// TODO: Generate bindings from extension_api.json

	Sys.println("Done!");
}
