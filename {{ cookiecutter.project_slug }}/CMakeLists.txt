cmake_minimum_required(VERSION 3.14)

## Set Project and Version
{% if cookiecutter.nwx_cmake %}
## Get CMaize and some CMake modules for exporting plugins to Python
include(cmake/get_cmake_modules.cmake)

# TODO: Uncomment when you have a git tag
#include(get_version_from_git)
#get_version_from_git(VERSION "${CMAKE_CURRENT_LIST_DIR}")
set(VERSION "0.0.1")  # Delete this line if you uncomment line above
{% else %}
set(VERSION "0.0.1") # Change this to your plugin's actual version
{% endif %}
project({{ cookiecutter.project_slug }} VERSION "${VERSION}" LANGUAGES CXX)

## Paths ##
set(${PROJECT_NAME}_SOURCE_DIR "${CMAKE_CURRENT_SOURCE_DIR}/src")
set(${PROJECT_NAME}_INCLUDE_DIR "${CMAKE_CURRENT_SOURCE_DIR}/include")
set(${PROJECT_NAME}_TESTS_DIR "${CMAKE_CURRENT_SOURCE_DIR}/tests")

{% if cookiecutter.nwx_cmake %}
include(nwx_versions)
{% else %}
include(cmake/get_cmake_modules.cmake)
{% endif %}

## Options ##
cmaize_option_list(
    BUILD_TESTING OFF "Should the tests be built?"
    INTEGRATION_TESTING OFF "Should the integration tests be built?"
)

## Find or build dependencies ##
cmaize_find_or_build_dependency(
    simde
    URL github.com/NWChemEx/SimDE
    VERSION master
    BUILD_TARGET simde
    FIND_TARGET nwx::simde
    CMAKE_ARGS BUILD_TESTING=OFF
)

## Add libraries ##
cmaize_add_library(
    ${PROJECT_NAME}
    SOURCE_DIR "${${PROJECT_NAME}_SOURCE_DIR}/${PROJECT_NAME}"
    INCLUDE_DIRS "${${PROJECT_NAME}_INCLUDE_DIR}/${PROJECT_NAME}"
    DEPENDS simde
)

{% if cookiecutter.nwx_cmake %}
include(nwx_pybind11)
nwx_add_pybind11_module(
    ${PROJECT_NAME}
    SOURCE_DIR "${${PROJECT_NAME}_SOURCE_DIR}/python"
    DEPENDS ${PROJECT_NAME}
)
{% endif %}

## Build tests ##
if("${BUILD_TESTING}")

    ## Find or build dependencies for tests
    cmaize_find_or_build_dependency(
        Catch2
        URL github.com/catchorg/Catch2
        BUILD_TARGET Catch2
        FIND_TARGET Catch2::Catch2
        VERSION v2.x
    )

    set(UNIT_TEST_DIR "${${PROJECT_NAME}_TESTS_DIR}/unit_tests")
    ## Add Tests ##
    cmaize_add_tests(
        test_${PROJECT_NAME}
        SOURCE_DIR "${UNIT_TEST_DIR}/${PROJECT_NAME}"
        INCLUDE_DIRS "${${PROJECT_NAME}_INCLUDE_DIR}/${PROJECT_NAME}"
        DEPENDS Catch2 ${PROJECT_NAME}
    )

    {% if cookiecutter.nwx_cmake %}
    if("${INTEGRATION_TESTING}")
        cmaize_find_or_build_dependency(
            nwchemex
            URL github.com/NWChemEx/NWChemEx
            BUILD_TARGET nwchemex
            FIND_TARGET nwx::nwchemex
            CMAKE_ARGS BUILD_TESTING=OFF
        )


        set(INTEGRATION_DIR "${${PROJECT_NAME}_TESTS_DIR}/integration_tests")
        nwx_pybind11_tests(
            py_${PROJECT_NAME}
            "${INTEGRATION_DIR}/${PROJECT_NAME}/test_${PROJECT_NAME}.py"
            DEPENDS nwchemex
            SUBMODULES simde chemist pluginplay parallelzone friendzone 
                       chemcache nwchemex
        )

    endif()
    {% endif %}

endif()

## Add package ##
cmaize_add_package(
    ${PROJECT_NAME} NAMESPACE ${PROJECT_NAME}::
)