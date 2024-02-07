Plugin Template
===============

This repository is intended to be used as a quickstart for writing a plugin
library consistent with [PluginPlay](https://github.com/NWChemEx/PluginPlay).

The primary contents of this repo are as follows:
- `README.md` - This file.
- `setup_new_plugin.sh` - The main component of this repo, used to generate the
  starting files for the new plugin. More on this below.
- `cmake/get_cmaize.cmake` - A CMake function to retrieve and include the 
  [CMaize](https://github.com/CMakePP/CMaize) library.
- `CMakeLists.txt` - The CMakeLists file for the new plugin produced by the
  running `setup_new_plugin.sh`.

## Generating the New Plugin
After cloning this repo, the first step is to run `setup_new_plugin.sh`. The
name of the new plugin (`plugin_name`) can either be passed as an argument when 
the script is called or you will be prompted for the name when the script runs.
After running the script, eight files should be produced:
- `plugin_name.txt` - Holds the name of the plugin. Used by `CMakeLists.txt`.
- `version.txt` - Holds the version of the plugin. Used by `CMakeLists.txt`.
- `toolchain.cmake` - A simple CMake toolchain. Ignored by Git.
- `include/{plugin_name}/{plugin_name}.hpp` - An initial courtesy header file.
- `include/{plugin_name}/{plugin_name}_mm.hpp` - A header file declaring the 
`load_modules` function of the plugin.
- `src/{plugin_name}/{plugin_name}_mm.cpp` - A source file defining the 
`load_modules` function of the plugin.
- `tests/unit_tests/test_main.cpp` - A main source file for a Catch2 test.
- `tests/unit_tests/test_load_modules.cpp` - A source file for a test of the 
`load_modules` function.

These files constitute a bare plugin library and a simple test for the 
`load_modules` function. New modules and property types shoudl be added and
registered following the [PluginPlay tutorials](https://nwchemex.github.io/PluginPlay/tutorials/index.html).

## Clean-Up
Once the new plugin has been generated, the developers will want to change the
git `origin` associated with the repo to one corresponding to the new plugin.
This is accomplished with the command 
```
git remote set-url origin {your_url_here}
```
Also, this markdown file should be modified to represent the new plugin.