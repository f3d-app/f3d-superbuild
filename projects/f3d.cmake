set(f3d_build_for_linux FALSE)
set(f3d_build_for_windows FALSE)
set(f3d_build_for_macos FALSE)
if (WIN32)
  set(f3d_build_for_windows TRUE)
elseif (APPLE)
  set(f3d_build_for_macos TRUE)
elseif (UNIX)
  set(f3d_build_for_linux TRUE)
endif ()

superbuild_add_project(f3d
  LICENSE_FILES
    LICENSE
    THIRD_PARTY_LICENSES.md
  DEPENDS vtk
  DEPENDS_OPTIONAL pybind11 alembic assimp occt
  CMAKE_ARGS
    -Werror=dev
    -Werror=deprecated
    --warn-uninitialized
    -DF3D_STRICT_BUILD=ON
    -DF3D_MODULE_EXTERNAL_RENDERING=ON
    -DF3D_MODULE_OCCT:BOOL=${occt_enabled}
    -DF3D_MODULE_ASSIMP:BOOL=${assimp_enabled}
    -DF3D_MODULE_ALEMBIC:BOOL=${alembic_enabled}
    -DF3D_MODULE_RAYTRACING:BOOL=${ospray_enabled}
    -DF3D_PYTHON_BINDINGS:BOOL=${pybind11_enabled}
    -DF3D_INSTALL_SDK=ON
    -DCMAKE_BUILD_TYPE=Release
    -DF3D_INSTALL_DEFAULT_CONFIGURATION_FILE=ON
    -DF3D_INSTALL_DEFAULT_CONFIGURATION_FILE_IN_PREFIX:BOOL=${f3d_build_for_linux}
    -DF3D_GENERATE_MAN:BOOL=${f3d_build_for_linux}
    -DF3D_INSTALL_MIME_TYPES_FILE:BOOL=${f3d_build_for_linux} # XXX: This change in master
    -DF3D_INSTALL_THUMBNAILER_FILES:BOOL=${f3d_build_for_linux}
    -DF3D_MACOS_BUNDLE:BOOL=${f3d_build_for_macos}
    -DF3D_WINDOWS_GUI:BOOL=${f3d_build_for_windows}
    -DCMAKE_MACOSX_RPATH=OFF
)

superbuild_apply_patch(f3d add-origin-loader-rpath
  "Add ORIGIN/loader_path in rpath")
