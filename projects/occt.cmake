set(occt_toolkits TKDESTEP TKDEIGES TKMesh TKBinXCAF)
list(JOIN occt_toolkits "${_superbuild_list_separator}" occt_toolkits_escaped)

if (NOT BUILD_SHARED_LIBS_occt STREQUAL "<same>")
  set(occt_build_shared ${BUILD_SHARED_LIBS_occt})
else ()
  set(occt_build_shared ${BUILD_SHARED_LIBS})
endif ()

set(occt_build_library_type "Static")
if (occt_build_shared)
  set(occt_build_library_type "Shared")
endif ()

superbuild_add_project(occt
  BUILD_SHARED_LIBS_INDEPENDENT
  LICENSE_FILES
    LICENSE_LGPL_21.txt
    OCCT_LGPL_EXCEPTION.txt
  CMAKE_ARGS
    -DBUILD_ADDITIONAL_TOOLKITS:STRING=${occt_toolkits_escaped}
    -DBUILD_DOC_Overview:BOOL=OFF
    -DBUILD_LIBRARY_TYPE:STRING=${occt_build_library_type}
    -DBUILD_MODULE_ApplicationFramework:BOOL=OFF
    -DBUILD_MODULE_DETools:BOOL=OFF
    -DBUILD_MODULE_DataExchange:BOOL=OFF
    -DBUILD_MODULE_Draw:BOOL=OFF
    -DBUILD_MODULE_FoundationClasses:BOOL=OFF
    -DBUILD_MODULE_ModelingAlgorithms:BOOL=OFF
    -DBUILD_MODULE_ModelingData:BOOL=OFF
    -DBUILD_MODULE_Visualization:BOOL=OFF
    -DCMAKE_INSTALL_RPATH:PATH=<INSTALL_DIR>/lib
    -DINSTALL_DIR_BIN:PATH=bin
    -DUSE_FREETYPE:BOOL=OFF
    -DUSE_XLIB:BOOL=OFF
)
