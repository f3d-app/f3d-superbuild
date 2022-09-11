cmake_minimum_required(VERSION 3.12)

project(f3d-superbuild)

function (superbuild_find_projects var)

  list(APPEND projects
    cxx11
    zlib
    bzip2
    png
    ffi
    sqlite
    xz
    rkcommon
    openvkl
    ospraymaterials
    pythonsetuptools
    ispc
    python3
    embree
    openimagedenoise
    ospray
    pybind11
    tbb
    vtk)

  set("${var}"
    ${projects}
    PARENT_SCOPE)
endfunction ()

list(APPEND superbuild_version_files
  "${CMAKE_CURRENT_LIST_DIR}/versions.cmake")
list(APPEND superbuild_project_roots
  "${CMAKE_CURRENT_LIST_DIR}/projects")

# set the default arguments used for "git clone"
set(_git_clone_arguments_default --progress)

if (NOT EXISTS "${CMAKE_CURRENT_LIST_DIR}/superbuild/CMakeLists.txt")
  message(FATAL_ERROR "It appears as though the superbuild infrastructure "
                      "is missing; did you forget to do `git submodule init` "
                      "and `git submodule update`?")
endif ()

add_subdirectory(superbuild)
