superbuild_add_project(webifc
  BUILD_SHARED_LIBS_INDEPENDENT
  LICENSE_FILES
    LICENSE.md
  SOURCE_SUBDIR src/cpp
  CMAKE_ARGS
    -DCMAKE_POSITION_INDEPENDENT_CODE:BOOL=ON)

superbuild_apply_patch(webifc remove-std-format
  "Replace std::format with std::to_chars for compiler compatibility")
