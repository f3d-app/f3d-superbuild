
cmake_minimum_required(VERSION 3.12)

project(f3d-superbuild)

option(BUILD_SHARED_LIBS "Build shared libraries" ON)

list(INSERT CMAKE_MODULE_PATH 0
  "${CMAKE_CURRENT_LIST_DIR}/cmake")

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
    cxx17
    draco
    embree
    exodus
    f3d
    hdf5
    imath
    imgui
    ispc
    lz4
    netcdf
    occt
    openexr
    openimagedenoise
    openvdb
    openvkl
    ospray
    ospraymaterials
    png
    pybind11
    python3
    rkcommon
    sqlite
    szip
    tbb
    openusd
    vtk
    xz
    blosc
    zstd
    zlib)

  if (UNIX)
    list(APPEND projects
      bzip2
      ffi)

    if (NOT APPLE)
      list(APPEND projects
         egl
         osmesa)
    endif ()
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
set(_superbuild_default_exodus ON)
set(_superbuild_default_imgui ON)
set(_superbuild_default_occt ON)
set(_superbuild_default_openvdb ON)
set(_superbuild_default_openexr ON)
set(_superbuild_default_ospray ON)
set(_superbuild_default_pybind11 OFF)
set(_superbuild_default_tbb ON)
set(_superbuild_default_openusd ON)
set(_superbuild_ospray_default_selection "2.7.1")

if (NOT EXISTS "${CMAKE_CURRENT_LIST_DIR}/superbuild/CMakeLists.txt")
  message(FATAL_ERROR "It appears as though the superbuild infrastructure "
                      "is missing; did you forget to do `git submodule init` "
                      "and `git submodule update`?")
endif ()

add_subdirectory(superbuild)
