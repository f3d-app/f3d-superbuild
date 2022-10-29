cmake_minimum_required(VERSION 3.12)

project(f3d-superbuild)

function (superbuild_find_projects var)

  list(APPEND projects
    occt
    imath
    alembic
    cxx11
    assimp
    zlib
    bzip2
    png
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
    vtk
    f3d)

  if (UNIX)
    list(APPEND projects
      ffi)
  endif ()

  if (WIN32)
    list(APPEND projects
      pywin32)
  endif ()

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

# build F3D and all its optional dependencies by default
set(_superbuild_default_f3d ON)
set(_superbuild_default_alembic ON)
set(_superbuild_default_assimp ON)
set(_superbuild_default_occt ON)
set(_superbuild_default_ospray ON)
set(_superbuild_default_pybind11 ON)

if (NOT EXISTS "${CMAKE_CURRENT_LIST_DIR}/superbuild/CMakeLists.txt")
  message(FATAL_ERROR "It appears as though the superbuild infrastructure "
                      "is missing; did you forget to do `git submodule init` "
                      "and `git submodule update`?")
endif ()

add_subdirectory(superbuild)
