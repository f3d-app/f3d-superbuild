superbuild_add_project(imath
  LICENSE_FILES
    LICENSE.md
  CMAKE_ARGS
    -DBUILD_TESTING=OFF
    -DCMAKE_BUILD_TYPE=Release
    -DCMAKE_MACOSX_RPATH=OFF
)

superbuild_apply_patch(imath disable-macosx-rpath
  "Disable macosx rpath force")
