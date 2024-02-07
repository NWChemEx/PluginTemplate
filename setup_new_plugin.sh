#!/bin/sh

# This script sets up a new plugin with the input name
#
# Usage:
#   setup_new_plugin.sh [plugin_name]
#

###################
## Plugin Basics ##
###################
set -e # Exit with error if any command fails

if [ -z "$1" ]
then
  read -p "Enter the plugin library name: " plugin_name
else
  plugin_name=$1
fi

## plugin_name.txt
cat << EOF > plugin_name.txt
${plugin_name}
EOF

## version.txt
cat << EOF > version.txt
0.0.0
EOF

## toolchain.cmake
cat << EOF > toolchain.cmake
set(BUILD_TESTING ON)
set(BUILD_SHARED_LIBS ON)
set(CMAKE_POSITION_INDEPENDENT_CODE TRUE)
set(NWX_MODULE_DIRECTORY ./install/python)
EOF

###################
## include files ##
###################
mkdir -p include/${plugin_name}

## include/${plugin_name}/${plugin_name}_mm.hpp
cat << EOF > include/${plugin_name}/${plugin_name}_mm.hpp
#pragma once
#include <pluginplay/module_manager.hpp>

namespace ${plugin_name} {

/** @brief Loads the modules contained in the plugin into the provided 
 *         ModuleManager instance.
 */
void load_modules(pluginplay::ModuleManager& mm);

} // namespace ${plugin_name}
EOF

## include/${plugin_name}/${plugin_name}.hpp
cat << EOF > include/${plugin_name}/${plugin_name}.hpp
#pragma once

#include "${plugin_name}_mm.hpp"
EOF

###############
## src files ##
###############
mkdir -p src/${plugin_name}

## src/${plugin_name}/${plugin_name}_mm.cpp
cat << EOF > src/${plugin_name}/${plugin_name}_mm.cpp
#include "${plugin_name}/${plugin_name}_mm.hpp"

namespace ${plugin_name} {

inline void set_defaults(pluginplay::ModuleManager& mm) {
    // Default submodules between collections can be set here
}

void load_modules(pluginplay::ModuleManager& mm) {
    // Add subcollection load calls here

    // Assign default submodules
    set_defaults(mm);
}

} // namespace ${plugin_name}
EOF

#################
## tests files ##
#################
mkdir -p tests/unit_tests

## tests/unit_tests/test_main.cpp
cat << EOF > tests/unit_tests/test_main.cpp
#define CATCH_CONFIG_RUNNER
#include <catch2/catch.hpp>

int main(int argc, char* argv[]) {
    int res = Catch::Session().run(argc, argv);
    return res;
}
EOF

## tests/unit_tests/test_load_modules.cpp
cat << EOF > tests/unit_tests/test_load_modules.cpp
#include <catch2/catch.hpp>
#include <${plugin_name}/${plugin_name}.hpp>
#include <plugin/plugin.hpp>

TEST_CASE("load_modules") {
    pluginplay::ModuleManager mm;
    ${plugin_name}::load_modules(mm);
}
EOF

############
## Finish ##
############
echo "New plugin ${plugin_name} created."
echo "Configure, build, and test as follows:"
echo "cmake -Bbuild -H. -DCMAKE_TOOLCHAIN_FILE=./toolchain.cmake -DCMAKE_INSTALL_PREFIX=./install"
echo "cmake --build build"
echo "cd build && ctest -VV"