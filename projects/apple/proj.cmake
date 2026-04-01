superbuild_add_project(proj
  DEPENDS
    cxx11 nlohmannjson sqlite
  LICENSE_FILES
    COPYING
  SPDX_LICENSE_IDENTIFIER
    MIT
  SPDX_COPYRIGHT_TEXT
    # Authors file reference the github contributors page
    "Copyright The proj contributors"
  CMAKE_ARGS
    -DCMAKE_INSTALL_LIBDIR:STRING=lib
    -DCMAKE_INSTALL_NAME_DIR:PATH=<INSTALL_DIR>/lib
    -DCMAKE_INSTALL_MANDIR:STRING=share/man
    -DBUILD_APPS:BOOL=OFF
    -DBUILD_TESTING:BOOL=OFF
    -DENABLE_CURL:BOOL=OFF
    -DENABLE_TIFF:BOOL=OFF
    -DNLOHMANN_JSON_ORIGIN:STRING=external)

# https://github.com/OSGeo/PROJ/issues/4730
superbuild_apply_patch(proj fix-database-location
  "fix database location")
