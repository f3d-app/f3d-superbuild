# NOTE: This file is duplicated from common-superbuild because of the need for the patch at the end of the file

if (BUILD_SHARED_LIBS)
  set(python3_shared_args --enable-shared)
else ()
  set(python3_shared_args --disable-shared --enable-static)
endif ()

set(python3_environment)
if (APPLE AND CMAKE_OSX_DEPLOYMENT_TARGET)
  list(APPEND python3_environment
    MACOSX_DEPLOYMENT_TARGET "${CMAKE_OSX_DEPLOYMENT_TARGET}")
endif ()

set(python3_optional_depends)
set(python3_args)
if (_superbuild_enable_openssl)
  list(APPEND python3_optional_depends
    openssl)
  if (openssl_enabled)
    if (openssl_built_by_superbuild)
      list(APPEND python3_args
        --with-openssl=<INSTALL_DIR>)
    else ()
      list(APPEND python3_args
        --with-openssl)
    endif ()
  endif ()
endif ()

set(python3_depends)
if (python3_SOURCE_SELECTION VERSION_GREATER_EQUAL "3.12")
  if (NOT APPLE)
    list(APPEND python3_depends
      utillinux)
  endif ()
  list(APPEND python3_environment
    # Keep the "system" `-I` flag from `pkgconf` for `lzma` on macOS.
    PKG_CONFIG_ALLOW_SYSTEM_CFLAGS 1
    # Keep the "system" `-L` flag from `pkgconf` when looking up `uuid` link
    # flags.
    PKG_CONFIG_ALLOW_SYSTEM_LIBS 1)
endif ()

superbuild_add_project(python3
  CAN_USE_SYSTEM
  DEPENDS bzip2 zlib png ffi sqlite xz pkgconf ${python3_depends}
  DEPENDS_OPTIONAL ${python3_optional_depends}
  LICENSE_FILES
    LICENSE
  SPDX_LICENSE_IDENTIFIER
    Python-2.0
  SPDX_COPYRIGHT_TEXT
    "Copyright (c) 2001, 2002, 2003, 2004, 2005, 2006, 2007, 2008, 2009, 2010, 2011, 2012, 2013, 2014, 2015, 2016, 2017, 2018, 2019, 2020, 2021, 2022, 2023 Python Software Foundation"
  CONFIGURE_COMMAND
    <SOURCE_DIR>/configure
      --prefix=<INSTALL_DIR>
      --with-ensurepip=install
      --with-pymalloc
      --without-pydebug
      ${python3_shared_args}
      ${python3_args}
  BUILD_COMMAND
    $(MAKE)
  INSTALL_COMMAND
    make install
  PROCESS_ENVIRONMENT
    ${python3_environment})

superbuild_project_add_step(python-symlink
  COMMAND   "${CMAKE_COMMAND}" -E create_symlink
            python3
            "<INSTALL_DIR>/bin/python"
  DEPENDEES build
  DEPENDERS install
  COMMENT   "Create a `python` symlink to `python3`"
  WORKING_DIRECTORY <SOURCE_DIR>)

if (NOT CMAKE_CROSSCOMPILING)
  # Pass the -rpath flag when building python to avoid issues running the
  # executable we built.
  superbuild_append_flags(
    ld_flags "-Wl,-rpath,${superbuild_install_location}/lib"
    PROJECT_ONLY)
endif ()

if (APPLE AND CMAKE_OSX_DEPLOYMENT_TARGET)
  superbuild_append_flags(c_flags
    "-mmacosx-version-min=${CMAKE_OSX_DEPLOYMENT_TARGET}"
    PROJECT_ONLY)
endif ()

if (python3_enabled)
  set(superbuild_python_executable "${superbuild_install_location}/bin/python3"
    CACHE INTERNAL "")
  set(superbuild_python_pip "${superbuild_install_location}/bin/pip3"
    CACHE INTERNAL "")
elseif (superbuild_build_phase)
  unset(superbuild_python_executable CACHE)
  unset(superbuild_python_pip CACHE)
endif ()

set(superbuild_python_version "${python3_SOURCE_SELECTION}"
  CACHE INTERNAL "")

if (python3_SOURCE_SELECTION STREQUAL "3.9")
  # Backport parts from:
  # a871f692b4a2e6c7d45579693e787edc0af1a02c
  # 93a0ef76473683aa3ad215e11df18f7839488c4e
  # 3309113d6131e4bbac570c4f54175ecca02d025a
  #
  # Some context was changed in order to apply to 3.9.5.
  superbuild_apply_patch(python3 ssl-fixes
    "Backport various SSL fixes")
endif()

superbuild_add_extra_cmake_args(
  -DPython_EXECUTABLE:FILEPATH=<INSTALL_DIR>/bin/python${superbuild_python_version}
  -DPython_INCLUDE_DIR:PATH=<INSTALL_DIR>/include/python${superbuild_python_version}
  -DPython_LIBRARY:FILEPATH=<INSTALL_DIR>/lib/libpython${superbuild_python_version}${CMAKE_SHARED_LIBRARY_SUFFIX}
  -DPython_LIBRARY_RELEASE:FILEPATH=<INSTALL_DIR>/lib/libpython${superbuild_python_version}${CMAKE_SHARED_LIBRARY_SUFFIX}

  -DPython3_EXECUTABLE:FILEPATH=<INSTALL_DIR>/bin/python${superbuild_python_version}
  -DPython3_INCLUDE_DIR:PATH=<INSTALL_DIR>/include/python${superbuild_python_version}
  -DPython3_LIBRARY:FILEPATH=<INSTALL_DIR>/lib/libpython${superbuild_python_version}${CMAKE_SHARED_LIBRARY_SUFFIX}
  -DPython3_LIBRARY_RELEASE:FILEPATH=<INSTALL_DIR>/lib/libpython${superbuild_python_version}${CMAKE_SHARED_LIBRARY_SUFFIX}

  -DPYTHON_EXECUTABLE:FILEPATH=<INSTALL_DIR>/bin/python${superbuild_python_version}
  -DPYTHON_INCLUDE_DIR:PATH=<INSTALL_DIR>/include/python${superbuild_python_version}
  -DPYTHON_LIBRARY:FILEPATH=<INSTALL_DIR>/lib/libpython${superbuild_python_version}${CMAKE_SHARED_LIBRARY_SUFFIX}
  -DPYTHON_LIBRARY_RELEASE:FILEPATH=<INSTALL_DIR>/lib/libpython${superbuild_python_version}${CMAKE_SHARED_LIBRARY_SUFFIX}
)

set(python3_modules_to_remove)
if (python3_SOURCE_SELECTION VERSION_LESS "3.12")
  list(APPEND python3_modules_to_remove
    ctypes.test
    distutils.tests
    lib2to3.tests
    unittest.test)
endif ()
_superbuild_remove_python_modules("${python3_modules_to_remove}")

# Quick and ugly patch for issue link
superbuild_apply_patch(python3 remove-ssl-impl "Remove SSL impl")
