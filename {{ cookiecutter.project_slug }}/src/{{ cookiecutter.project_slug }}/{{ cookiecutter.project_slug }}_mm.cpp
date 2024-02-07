#include "{{ cookiecutter.project_slug }}/{{ cookiecutter.project_slug }}_mm.hpp"

namespace {{ cookiecutter.project_slug }} {

inline void set_defaults(pluginplay::ModuleManager& mm) {
    // Default submodules between collections can be set here
}

DECLARE_PLUGIN({{ cookiecutter.project_slug }}) {
    // Add subcollection load calls here

    // Assign default submodules
    set_defaults(mm);
}

} // namespace {{ cookiecutter.project_slug }}
