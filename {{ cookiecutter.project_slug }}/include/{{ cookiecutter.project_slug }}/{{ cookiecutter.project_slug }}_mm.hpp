#pragma once
#include <pluginplay/plugin/plugin.hpp>

namespace {{ cookiecutter.project_slug }} {

/** @brief Loads the modules contained in the plugin into the provided 
 *         ModuleManager instance.
 */
DECLARE_PLUGIN({{ cookiecutter.project_slug }});

} // namespace {{ cookiecutter.project_slug }}
