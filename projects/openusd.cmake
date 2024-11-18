superbuild_add_project(openusd
  BUILD_SHARED_LIBS_INDEPENDENT
  LICENSE_FILES
    LICENSE.txt
  DEPENDS tbb
  CMAKE_ARGS
    -DPXR_BUILD_EXAMPLES:BOOL=OFF
    -DPXR_BUILD_IMAGING:BOOL=OFF
    -DPXR_BUILD_MONOLITHIC:BOOL=ON
    -DPXR_BUILD_TESTS:BOOL=OFF
    -DPXR_BUILD_TUTORIALS:BOOL=OFF
    -DPXR_BUILD_USD_TOOLS:BOOL=OFF
    -DPXR_ENABLE_GL_SUPPORT:BOOL=OFF
    -DPXR_ENABLE_PYTHON_SUPPORT:BOOL=OFF
    -DPXR_INSTALL_LOCATION:STRING=../lib/usd
)

# For some reason, pdb files and parallel build on Windows are causing issues
superbuild_apply_patch(openusd msvc-defaults "Remove PDB generation and parallel build")

# Upstream issue: https://github.com/PixarAnimationStudios/OpenUSD/issues/2490
superbuild_apply_patch(openusd install-bin "Install Windows DLL in bin directory")
