superbuild_add_project(occt
  LICENSE_FILES
    LICENSE_LGPL_21.txt
    OCCT_LGPL_EXCEPTION.txt
  CMAKE_ARGS
#    -DBUILD_ADDITIONAL_TOOLKITS="TKSTEP;TKIGES;TKMesh" # Do not work for some reason
    -DBUILD_MODULE_ApplicationFramework=OFF
    -DBUILD_MODULE_DataExchange=ON
    -DBUILD_MODULE_Draw=OFF
    -DBUILD_MODULE_FoundationClasses=OFF
    -DBUILD_MODULE_ModelingAlgorithms=ON
    -DBUILD_MODULE_ModelingData=OFF
    -DBUILD_MODULE_Visualization=OFF
    -DCMAKE_BUILD_TYPE=Release
)
