cmake_minimum_required(VERSION 3.12)

project(f3d-superbuild)

macro (superbuild_setup_variables)
  include(SuperbuildVersionMacros)
  if (f3d_SOURCE_SELECTION STREQUAL "git")
    # Assuming master; just use the latest version, but let the user set their
    # own version in case it is actually a branch from some other version.
    set(F3D_VERSION_DEFAULT "2.0.0"
      CACHE STRING "The default version of F3D to use if it cannot be detected")
    mark_as_advanced(F3D_VERSION_DEFAULT)
    set(f3d_default_version "${F3D_VERSION_DEFAULT}")
  elseif (f3d_SOURCE_SELECTION STREQUAL "source")
    # If it is a git repo, we'll get it that way.
    set(f3d_default_version "")
  else ()
    # The selection is the version number; use it.
    set(f3d_default_version "${f3d_SOURCE_SELECTION}")
  endif()
  superbuild_set_version_variables(f3d "${f3d_default_version}" "f3d-version.cmake")
endmacro ()

function (superbuild_find_projects var)

  list(APPEND projects
    alembic
    assimp
    cxx11
    draco
    embree
    f3d
    imath
    ispc
    occt
    openimagedenoise
    openvkl
    ospray
    ospraymaterials
    png
    pybind11
    python3
    pythonsetuptools
    rkcommon
    sqlite
    tbb
    vtk
    xz
    zlib)

  if (UNIX)
    list(APPEND projects
      bzip2
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

function (superbuild_add_packaging)
  # Packaging tests
  if (WIN32)
    set(generators
      ZIP
      NSIS)
  elseif (APPLE)
    set(generators
      DragNDrop)
  else ()
    set(generators
      TGZ
      TXZ
      DEB)
  endif ()
  foreach (generator IN LISTS generators)
    superbuild_add_extra_package_test(f3d "${generator}"
      LABELS  "F3D"
      TIMEOUT 6400)
  endforeach ()

endfunction ()

function (superbuild_add_tests)
  add_subdirectory("${CMAKE_SOURCE_DIR}/testing" "${CMAKE_BINARY_DIR}/Testing")
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
set(_superbuild_default_draco ON)
set(_superbuild_default_occt ON)
set(_superbuild_default_ospray ON)
set(_superbuild_default_pybind11 OFF)

# shared libs managements
set(F3D_SHARED_LIBS_STYLE "Standard" CACHE STRING "Control how shared libs should be managed when building F3D and its dependencies")
set_property(CACHE F3D_SHARED_LIBS_STYLE PROPERTY STRINGS Standard Shared Static)
set(BUILD_SHARED_LIBS ON CACHE INTERNAL "")
if (F3D_SHARED_LIBS_STYLE STREQUAL "Standard")
  set(BUILD_SHARED_LIBS_alembic OFF CACHE INTERNAL "")
  set(BUILD_SHARED_LIBS_assimp OFF CACHE INTERNAL "")
  set(BUILD_SHARED_LIBS_draco OFF CACHE INTERNAL "")
  set(BUILD_SHARED_LIBS_imath OFF CACHE INTERNAL "")
  set(BUILD_SHARED_LIBS_occt OFF CACHE INTERNAL "")
  set(BUILD_SHARED_LIBS_vtk OFF CACHE INTERNAL "")
  set(BUILD_SHARED_LIBS_f3d ON CACHE INTERNAL "")
elseif (F3D_SHARED_LIBS_STYLE STREQUAL "Shared")
  set(BUILD_SHARED_LIBS_alembic ON CACHE INTERNAL "")
  set(BUILD_SHARED_LIBS_assimp ON CACHE INTERNAL "")
  set(BUILD_SHARED_LIBS_draco ON CACHE INTERNAL "")
  set(BUILD_SHARED_LIBS_imath ON CACHE INTERNAL "")
  set(BUILD_SHARED_LIBS_occt ON CACHE INTERNAL "")
  set(BUILD_SHARED_LIBS_vtk ON CACHE INTERNAL "")
  set(BUILD_SHARED_LIBS_f3d ON CACHE INTERNAL "")
elseif (F3D_SHARED_LIBS_STYLE STREQUAL "Static")
  set(BUILD_SHARED_LIBS OFF CACHE INTERNAL "")
  set(BUILD_SHARED_LIBS_alembic OFF CACHE INTERNAL "")
  set(BUILD_SHARED_LIBS_assimp OFF CACHE INTERNAL "")
  set(BUILD_SHARED_LIBS_draco OFF CACHE INTERNAL "")
  set(BUILD_SHARED_LIBS_imath OFF CACHE INTERNAL "")
  set(BUILD_SHARED_LIBS_occt OFF CACHE INTERNAL "")
  set(BUILD_SHARED_LIBS_vtk OFF CACHE INTERNAL "")
  set(BUILD_SHARED_LIBS_f3d OFF CACHE INTERNAL "")

  if (ENABLE_ospray)
    message(FATAL_ERROR "Static build with ospray enabled is not supported")
  endif ()
endif ()

if (NOT EXISTS "${CMAKE_CURRENT_LIST_DIR}/superbuild/CMakeLists.txt")
  message(FATAL_ERROR "It appears as though the superbuild infrastructure "
                      "is missing; did you forget to do `git submodule init` "
                      "and `git submodule update`?")
endif ()

add_subdirectory(superbuild)
