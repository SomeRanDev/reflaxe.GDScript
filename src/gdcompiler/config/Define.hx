package gdcompiler.config;

enum abstract Define(String) from String to String {
	/**
		-D generate_godot_plugin

		If defined, a Godot plugin will be generated with the output.
	**/
	var GenerateGodotPlugin = "generate_godot_plugin";

	/**
		-D godot_plugin_name=NAME

		Defines the "name" entry in `plugin.cfg` if a plugin is generated.
	**/
	var GodotPluginName = "godot_plugin_name";

	/**
		-D godot_plugin_description=DESCRIPTION

		Defines the "description" entry in `plugin.cfg` if a plugin is generated.
	**/
	var GodotPluginDescription = "godot_plugin_description";

	/**
		-D godot_plugin_author=AUTHOR

		Defines the "author" entry in `plugin.cfg` if a plugin is generated.
	**/
	var GodotPluginAuthor = "godot_plugin_author";

	/**
		-D godot_plugin_version=VERSION

		Defines the "version" entry in `plugin.cfg` if a plugin is generated.
	**/
	var GodotPluginVersion = "godot_plugin_version";

	/**
		-D godot_plugin_script_name=FILE_NAME.gd

		Sets the name of the "script" file generated for the plugin.
	**/
	var GodotPluginScriptName = "godot_plugin_script_name";
	
	/**
		-D gdscript_output_dirs

		If defined, the GDScript is generated in folders based on the package.
	**/
	var GDScriptOutputDirs = "gdscript_output_dirs";

	/**
		-D gdscript_snake_case

		If defined, features will use snake-case instead of camel-case.
	**/
	var GDScriptUseSnakeCase = "gdscript_snake_case";

	/**
		-D gdscript_always_packages_in_output_filenames

		If defined, the file names will include the package path even if 
		`-D gdscript_output_dirs` is defined.
	**/
	var GDScriptAlwaysUsePackagesInOutputFilenames = "gdscript_always_packages_in_output_filenames";

	/**
		-D generate_resource_export_list

		If defined, a `.txt` file contained a comma separated list of preloaded
		paths will be generated. These will be taken from uses of `@:const(preload = "path")`
		and do not account for normal calls to `preload` at the moment.
	**/
	var GenerateResourceExportList = "generate_resource_export_list";
}
