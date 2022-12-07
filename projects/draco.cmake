superbuild_add_project(draco
  LICENSE_FILES
    LICENSE
  CMAKE_ARGS
    -DDRACO_BACKWARDS_COMPATIBILITY=OFF
    -DDRACO_JS_GLUE=OFF
    -DDRACO_PREDICTIVE_EDGEBREAKER=OFF
    -DDRACO_STANDARD_EDGEBREAKER=OFF
    -DCMAKE_BUILD_TYPE=Release
    -DBUILD_SHARED_LIBS=ON
)

superbuild_apply_patch(draco fix-pic "Fix usage of PIC")
superbuild_apply_patch(draco fix-install "Fix install directory")
