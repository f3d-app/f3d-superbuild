# TODO
superbuild_add_project(szip
  LICENSE_FILES
    COPYING
  SPDX_LICENSE_IDENTIFIER
    LicenseRef-SZIP
  SPDX_COPYRIGHT_TEXT
    "Copyright (C) 2001 Science & Technology Corporation @ UNM"
    "Copyright (C) 2003 Lowell H. Miles and Jack A. Venbrux"
  SPDX_CUSTOM_LICENSE_FILE
    COPYING
  SPDX_CUSTOM_LICENSE_NAME
    LicenseRef-SZIP
  CMAKE_ARGS
    -DCMAKE_INSTALL_NAME_DIR:STRING=<INSTALL_DIR>/lib
    -DCMAKE_POLICY_VERSION_MINIMUM=3.5
    -DSZIP_ENABLE_ENCODING:BOOL=OFF # This option should not be changed as we do not distribute the encoding/compression license
    -DSZIP_INSTALL_DATA_DIR:STRING=share
    -DSZIP_INSTALL_CMAKE_DIR:STRING=lib/cmake/SZIP
    -DBUILD_SHARED_LIBS:BOOL=ON
    -DBUILD_TESTING:BOOL=OFF)

superbuild_apply_patch(szip remove_compression_license
  "Remove compression license from szip license file as szip is compiled without encoding support")
