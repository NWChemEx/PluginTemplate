#include <{{ cookiecutter.project_slug }}/{{ cookiecutter.project_slug }}_mm.hpp>

namespace {{ cookiecutter.project_slug }} {

inline void set_defaults(pluginplay::ModuleManager & mm) {
   // Set your modules' default submodules here
}

DECLARE_PLUGIN({{ cookiecutter.project_slug }}) {
    // Add your modules to mm here

    set_defaults(mm);
}

} // namespace {{ cookiecutter.project_slug }}
