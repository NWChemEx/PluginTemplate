#include <catch2/catch.hpp>
#include <{{ cookiecutter.project_slug }}/{{ cookiecutter.project_slug }}.hpp>

TEST_CASE("load_modules") {
    pluginplay::ModuleManager mm;
    {{ cookiecutter.project_slug }}::load_modules(mm);
}
