option(OCCT_ENABLE_COLORING "Enable Coloring modules in OCCT" ON)
mark_as_advanced(OCCT_ENABLE_COLORING)

set(occt_toolkits TKSTEP TKIGES TKMesh)
if (OCCT_ENABLE_COLORING)
  list(APPEND occt_toolkits TKXDESTEP TKXDEIGES)
endif ()

list(JOIN occt_toolkits "${_superbuild_list_separator}" occt_toolkits_escaped)

superbuild_add_project(occt
  LICENSE_FILES
    LICENSE_LGPL_21.txt
    OCCT_LGPL_EXCEPTION.txt
  CMAKE_ARGS
    -DBUILD_ADDITIONAL_TOOLKITS=${occt_toolkits_escaped}
    -DBUILD_DOC_Overview=OFF
    -DBUILD_MODULE_ApplicationFramework=OFF
    -DBUILD_MODULE_DataExchange=OFF
    -DBUILD_MODULE_Draw=OFF
    -DBUILD_MODULE_FoundationClasses=OFF
    -DBUILD_MODULE_ModelingAlgorithms=OFF
    -DBUILD_MODULE_ModelingData=OFF
    -DBUILD_MODULE_Visualization=OFF
    -DCMAKE_BUILD_TYPE=Release
    -DCMAKE_INSTALL_RPATH=<INSTALL_DIR>/lib
    -DINSTALL_DIR_BIN:PATH=bin
    -DUSE_FREETYPE=OFF
)
