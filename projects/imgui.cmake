superbuild_add_project(imgui
  BUILD_SHARED_LIBS_INDEPENDENT
  LICENSE_FILES
    LICENSE.txt
)

superbuild_apply_patch(imgui cmake-build "Add CMake build system")
