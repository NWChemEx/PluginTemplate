include_guard()

macro(get_nwx_cmake)
    include(FetchContent)
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
endmacro()

get_nwx_cmake()