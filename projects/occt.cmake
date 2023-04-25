set(occt_toolkits TKSTEP TKIGES TKMesh TKXDESTEP TKXDEIGES)
list(JOIN occt_toolkits "${_superbuild_list_separator}" occt_toolkits_escaped)

set(occt_depends)
if (UNIX AND NOT APPLE)
  list(APPEND occt_depends
    fontconfig)
endif ()

superbuild_add_project(occt
  LICENSE_FILES
    LICENSE_LGPL_21.txt
    OCCT_LGPL_EXCEPTION.txt
  DEPENDS freetype ${occt_depends}
  CMAKE_ARGS
    -DINSTALL_DIR_BIN:PATH=bin
    -DBUILD_ADDITIONAL_TOOLKITS=${occt_toolkits_escaped}
    -DBUILD_MODULE_ApplicationFramework=OFF
    -DBUILD_MODULE_DataExchange=OFF
    -DBUILD_MODULE_Draw=OFF
    -DBUILD_MODULE_FoundationClasses=OFF
    -DBUILD_MODULE_ModelingAlgorithms=OFF
    -DBUILD_MODULE_ModelingData=OFF
    -DBUILD_MODULE_Visualization=OFF
    -DBUILD_DOC_Overview=OFF
    -DCMAKE_BUILD_TYPE=Release
    -DCMAKE_INSTALL_RPATH=<INSTALL_DIR>/lib
)
