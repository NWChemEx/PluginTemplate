Plugin Template
===============

This repository is intended to be used as a quickstart for writing a plugin
library consistent with [PluginPlay](https://github.com/NWChemEx/PluginPlay).

## Generating the New Plugin

This template is generated with the 
[Cookiecutter](https://github.com/cookiecutter/cookiecutter) package:

```bash
# Install cookiecutter, if not already
$ pip install cookiecutter
# Generate the template
$ cookiecutter https://github.com/NWChemEx/PluginTemplate.git
```
Follow the resulting two prompts to generate your plugin. The resulting directory
will contain the following:
- `version.txt` - Holds the version of the plugin. Used by `CMakeLists.txt`.
- `default_toolchain.cmake` - A simple CMake toolchain. Ignored by Git.
- `include/{plugin_name}/{plugin_name}.hpp` - An initial courtesy header file.
- `include/{plugin_name}/{plugin_name}_mm.hpp` - A header file declaring the plugin.
- `src/{plugin_name}/{plugin_name}_mm.cpp` - A source file defining the the plugin.
- `tests/unit_tests/test_main.cpp` - A main source file for a Catch2 test.
- `tests/unit_tests/test_load_modules.cpp` - A source file for a test of the `load_modules` function.

These files constitute a bare plugin library and a simple test for the 
`load_modules` function. New modules and property types can be added and
registered following the [PluginPlay tutorials](https://nwchemex.github.io/PluginPlay/tutorials/index.html).
The resulting library will depend on [SimDE](https://github.com/NWChemEx/SimDE).
See [here](https://nwchemex.github.io/SimDE/install.html#simde-dependencies) for
the further info on SimDE's dependencies. You can configure, build, and test the
new plugin as follows:

```bash
$ cmake -Bbuild -H. -DCMAKE_TOOLCHAIN_FILE=./default_toolchain.cmake -DCMAKE_INSTALL_PREFIX=./install
$ cmake --build build --parallel 2
$ cd build
$ ctest -VV
```

At this point, you can initialize git and set up remotes:

```bash
$ git init
$ git add .
$ git commit -m "Initial State"
$ git remote add origin {Your Remote Repo}
$ git push -u origin master
```

# Contributing

- [Contributor Guidelines](https://github.com/NWChemEx/.github/blob/1a883d64519f62da7c8ba2b28aabda7c6f196b2c/.github/CONTRIBUTING.md)
- [Contributor License Agreement](https://github.com/NWChemEx/.github/blob/master/.github/CONTRIBUTING.md#contributor-license-agreement-cla)
- [Code of Conduct](https://github.com/NWChemEx/.github/blob/master/.github/CODE_OF_CONDUCT.md)

# Acknowledgments

Add...
