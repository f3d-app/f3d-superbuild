set(mesa_common_config_args
  --libdir lib
  --buildtype=release
  --prefix=<INSTALL_DIR>
  -Dauto_features=disabled
  -Dzstd=disabled
  -Dvulkan-drivers=
  -Dshared-glapi=disabled
  -Degl=disabled
  -Dllvm=enabled
  -Dgles1=disabled
  -Dgles2=disabled)

set(mesa_depends_optional)
if (UNIX AND NOT APPLE)
  list(APPEND mesa_depends_optional
    mesatoolchainoverride)
endif ()

set(mesa_depends)

if (mesa_SOURCE_SELECTION STREQUAL "25.0.7")
  list(APPEND mesa_common_config_args
    -Dgallium-drivers=llvmpipe
    -Dxmlconfig=disabled)

  if (expat_enabled)
    list(APPEND mesa_common_config_args
      -Dexpat=enabled)
  else ()
    list(APPEND mesa_common_config_args
      -Dexpat=disabled)
  endif ()

  if (NOT WIN32)
    list(APPEND mesa_depends_optional
      expat)
  endif ()

else ()
  list(APPEND mesa_common_config_args
    -Dgallium-drivers=swrast)

  if (NOT WIN32)
    list(APPEND mesa_depends
      expat)
  endif ()

endif()

if (mesa_SOURCE_SELECTION STREQUAL "22.3.3")
  list(APPEND mesa_common_config_args
    -Ddri-drivers=)
endif()

if (NOT llvm_is_shared)
  list(APPEND mesa_common_config_args
    -Dshared-llvm=disabled)
else ()
  list(APPEND mesa_common_config_args
    -Dshared-llvm=enabled)
endif ()

if (zlib_enabled)
  list(APPEND mesa_common_config_args -Dzlib=disabled)
else ()
  list(APPEND mesa_common_config_args
    -Dzlib=disabled)
endif ()

if (CMAKE_CXX_COMPILER_ID MATCHES "Intel")
  superbuild_append_flags(
    c_flags "-diag-disable=279,557,10006"
    PROJECT_ONLY)
  superbuild_append_flags(
    cxx_flags "-diag-disable=177,279,557,873,10006"
    PROJECT_ONLY)
endif ()

set(mesa_environment
  LLVM_CONFIG "${llvm_dir}/bin/llvm-config")
if (WIN32)
  list(APPEND mesa_environment
    PATH <INSTALL_DIR>/Python
    PATH <INSTALL_DIR>/bin)
endif ()

set(mesa_install_conflict_args)
set(mesa_need_install_depends 0)
if (superbuild_build_phase AND
    mesa_enabled AND
    osmesa_enabled)
  # Create targets for the "install" step of each `mesa` project.
  list(APPEND mesa_install_conflict_args
    STEP_TARGETS install)
  set(mesa_need_install_depends 1)
  if (project STREQUAL "mesa")
    string(APPEND mesa_need_install_depends
      DEPENDS_ORDERED osmesa)
  endif ()
endif ()

superbuild_add_project(${project}
  CAN_USE_SYSTEM
  DEPENDS_OPTIONAL
    zlib
    ${mesa_depends_optional}
  ${mesa_install_conflict_args}
  DEPENDS
    llvm
    pythonmako
    pythonpyyaml
    meson
    python3
    flexbison
    ${mesa_depends}
  LICENSE_FILES
    docs/license.rst
  SPDX_LICENSE_IDENTIFIER
    MIT
  SPDX_COPYRIGHT_TEXT
    "Copyright (C) 1999-2007  Brian Paul"
  CONFIGURE_COMMAND
    ${meson_command}
      ${mesa_common_config_args}
      ${mesa_type_args}
      build
  BUILD_COMMAND
    ${superbuild_ninja_command} -C build
  INSTALL_COMMAND
    ${superbuild_ninja_command} -C build install
  BUILD_IN_SOURCE 1
  PROCESS_ENVIRONMENT
    ${mesa_environment})

if (mesa_need_install_depends)
  if (project STREQUAL "mesa")
    # Make sure that `osmesa` and `mesa` do not install at the same time. On
    # Windows, a race exists where they try working on the same file at the
    # same time and the build fails. Defer the call as the project only exists
    # *after* this file is completely included.
    cmake_language(DEFER
      CALL ExternalProject_Add_StepDependencies
        mesa install osmesa-install)
  endif ()
endif ()

superbuild_append_flags(ld_flags
  "-Wl,-rpath,<INSTALL_DIR>/lib"
  PROJECT_ONLY)
