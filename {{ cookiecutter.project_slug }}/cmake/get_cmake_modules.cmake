include_guard()

macro(get_cmake_modules)
    include(FetchContent)

    {%- if cookiecutter.nwx_cmake -%}
    FetchContent_Declare(
        nwx_cmake
        GIT_REPOSITORY https://github.com/NWChemEx/NWXCMake
    )
    FetchContent_MakeAvailable(nwx_cmake)
    set(
        CMAKE_MODULE_PATH "${CMAKE_MODULE_PATH}" "${nwx_cmake_SOURCE_DIR}/cmake"
        CACHE STRING ""
        FORCE
    )
    {%- else -%}

    if("${CMAIZE_VERSION}" STREQUAL "")
        set(CMAIZE_VERSION v1.1.0 )
    endif()

    # Store whether we are building tests or not, then turn off the tests
    if(BUILD_TESTING)
        set(build_testing_old "${BUILD_TESTING}")
    endif()
    set(BUILD_TESTING OFF CACHE BOOL "" FORCE)

    # Download CMakePP and bring it into scope
    include(FetchContent)
    FetchContent_Declare(
        cmaize
        GIT_REPOSITORY https://github.com/CMakePP/CMaize
        GIT_TAG ${CMAIZE_VERSION}
    )
    FetchContent_MakeAvailable(cmaize)

    # Restore the previous value, if set
    # Unset otherwise
    if(build_testing_old)
        set(BUILD_TESTING "${build_testing_old}" CACHE BOOL "" FORCE)
    else()
        unset(BUILD_TESTING CACHE)
    endif()

    {% endif %}
endmacro()

get_cmake_modules()