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
    LICENSE.md
    doc/THIRD_PARTY_LICENSES.md
  DEPENDS vtk
  DEPENDS_OPTIONAL pybind11 alembic assimp draco occt
  CMAKE_ARGS
    -Werror=dev
    -Werror=deprecated
    --warn-uninitialized
    -DCMAKE_BUILD_TYPE=Release
    -DCMAKE_MACOSX_RPATH=OFF
    -DF3D_LINUX_GENERATE_MAN:BOOL=${f3d_build_for_linux}
    -DF3D_LINUX_INSTALL_DEFAULT_CONFIGURATION_FILE_IN_PREFIX:BOOL=${f3d_build_for_linux}
    -DF3D_MACOS_BUNDLE:BOOL=${f3d_build_for_macos}
    -DF3D_MODULE_EXTERNAL_RENDERING=ON
    -DF3D_MODULE_RAYTRACING:BOOL=${ospray_enabled}
    -DF3D_PLUGIN_BUILD_ALEMBIC:BOOL=${alembic_enabled}
    -DF3D_PLUGIN_BUILD_ASSIMP:BOOL=${assimp_enabled}
    -DF3D_PLUGIN_BUILD_DRACO:BOOL=${draco_enabled}
    -DF3D_PLUGIN_BUILD_OCCT:BOOL=${occt_enabled}
    -DF3D_PYTHON_BINDINGS:BOOL=${pybind11_enabled}
    -DF3D_STRICT_BUILD=ON
    -DF3D_WINDOWS_GUI:BOOL=${f3d_build_for_windows}
    -DF3D_WINDOWS_INSTALL_LOGOS_FOR_NSIS_PACKAGING:BOOL=${f3d_build_for_windows}
  )

# Installing components that are not part of the standard install
superbuild_project_add_step("extra-install"
  COMMAND ${CMAKE_COMMAND} --install <BINARY_DIR> --component mimetypes
  COMMAND ${CMAKE_COMMAND} --install <BINARY_DIR> --component configuration
  COMMAND ${CMAKE_COMMAND} --install <BINARY_DIR> --component sdk
  COMMENT
    "Installing extra components"
  DEPENDEES
    install
)
