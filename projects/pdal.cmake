set(pdal_platform_dependencies)
if (UNIX)
  list(APPEND pdal_platform_dependencies
    libxml2)
endif ()

set(pdal_zlib_include_dir)
if (zlib_enabled AND NOT USE_SYSTEM_zlib)
  list(APPEND pdal_zlib_include_dir
    -DZLIB_INCLUDE_DIR:PATH=<INSTALL_DIR>/include)
endif ()

superbuild_add_project(pdal
  BUILD_SHARED_LIBS_INDEPENDENT
  DEPENDS
    cxx17 gdal geotiff curl
  DEPENDS_OPTIONAL
    zlib zstd xerces ${pdal_platform_dependencies}
  LICENSE_FILES
    LICENSE.txt
  SPDX_LICENSE_IDENTIFIER
    BSD-3-Clause
  SPDX_COPYRIGHT_TEXT
    "Copyright (c) 2022, Hobu, Inc."
  CMAKE_ARGS
    -DWITH_BACKTRACE:BOOL=OFF
    -DWITH_TESTS:BOOL=OFF
    -DWITH_LZMA:BOOL=OFF
    -DWITH_ZLIB:BOOL=${zlib_enabled}
    -DWITH_ZSTD:BOOL=${zstd_enabled}
    -DBUILD_PLUGIN_E57:BOOL=${xerces_enabled}
    -DBUILD_PLUGIN_HDF:BOOL=OFF
    -DBUILD_PLUGIN_PGPOINTCLOUD:BOOL=OFF
    -DBUILD_TOOLS_LASDUMP:BOOL=OFF
    -DCMAKE_INSTALL_LIBDIR:STRING=lib
    -DCMAKE_INSTALL_NAME_DIR:PATH=<INSTALL_DIR>/lib
    -DCMAKE_INSTALL_RPATH:PATH=<INSTALL_DIR>/lib
    ${pdal_zlib_include_dir})

superbuild_apply_patch(pdal fix-sqlite3-configuration
  "Fix SQLite3 configuration")

# https://github.com/PDAL/PDAL/pull/4996
superbuild_apply_patch(pdal add-static-build-support
  "Add static build support")

include(CheckIncludeFileCXX)

check_include_file_cxx("filesystem" has_filesystem)
if (NOT has_filesystem)
  check_include_file_cxx("experimental/filesystem" has_experimental_filesystem)
  if (has_experimental_filesystem)
    superbuild_apply_patch(pdal fix-include-filesystem "Fix filesystem include")
  else()
    message(WARNING "Could not find <filesystem> or <experimental/filesystem> headers, PDAL may fail to compile")
  endif()
endif()
