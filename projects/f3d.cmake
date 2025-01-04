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

set (f3d_build_python_bindings FALSE)
if (pybind11_enabled AND python3_enabled)
  set (f3d_build_python_bindings TRUE)
endif ()

superbuild_add_project(f3d
  BUILD_SHARED_LIBS_INDEPENDENT
  LICENSE_FILES
    LICENSE.md
    doc/THIRD_PARTY_LICENSES.md
  DEPENDS vtk cxx17
  DEPENDS_OPTIONAL pybind11 alembic assimp draco imgui occt openexr openusd openvdb
  CMAKE_ARGS
    -DCMAKE_INSTALL_NAME_DIR:PATH=<INSTALL_DIR>/lib
    -DF3D_LINUX_GENERATE_MAN:BOOL=${f3d_build_for_linux}
    -DF3D_LINUX_INSTALL_DEFAULT_CONFIGURATION_FILE_IN_PREFIX:BOOL=${f3d_build_for_linux}
    -DF3D_MACOS_BUNDLE:BOOL=${f3d_build_for_macos}
    -DF3D_MODULE_EXR:BOOL=${openexr_enabled}
    -DF3D_MODULE_RAYTRACING:BOOL=${ospray_enabled}
    -DF3D_MODULE_UI:BOOL=${imgui_enabled}
    -DF3D_PLUGINS_STATIC_BUILD:BOOL=ON
    -DF3D_PLUGIN_BUILD_ALEMBIC:BOOL=${alembic_enabled}
    -DF3D_PLUGIN_BUILD_ASSIMP:BOOL=${assimp_enabled}
    -DF3D_PLUGIN_BUILD_DRACO:BOOL=${draco_enabled}
    -DF3D_PLUGIN_BUILD_EXODUS:BOOL=${exodus_enabled}
    -DF3D_PLUGIN_BUILD_OCCT:BOOL=${occt_enabled}
    -DF3D_PLUGIN_BUILD_USD:BOOL=${openusd_enabled}
    -DF3D_PLUGIN_BUILD_VDB:BOOL=${openvdb_enabled}
    -DF3D_BINDINGS_PYTHON:BOOL=${f3d_build_python_bindings}
    -DF3D_BINDINGS_PYTHON_GENERATE_STUBS:BOOL=${f3d_build_python_bindings}
    -DF3D_STRICT_BUILD:BOOL=OFF
    -DF3D_WINDOWS_GUI:BOOL=${f3d_build_for_windows}
    -DF3D_LINUX_LINK_FILESYSTEM:BOOL=OFF
    -DF3D_PLUGIN_OCCT_COLORING_SUPPORT:BOOL=ON
  )

# Installing components that are not part of the standard install
superbuild_project_add_step("extra-install-configurations"
  COMMAND ${CMAKE_COMMAND} --install <BINARY_DIR> --component configuration
  COMMENT
    "Installing configurations"
  DEPENDEES
    install
)

superbuild_project_add_step("extra-install-colormaps"
  COMMAND ${CMAKE_COMMAND} --install <BINARY_DIR> --component colormaps
  COMMENT
    "Installing colormaps"
  DEPENDEES
    install
)

if (UNIX AND NOT APPLE)
  superbuild_project_add_step("extra-install-mimetypes"
    COMMAND ${CMAKE_COMMAND} --install <BINARY_DIR> --component mimetypes
    COMMENT
      "Installing linux mimetypes"
    DEPENDEES
      install
  )
endif ()

if (BUILD_SHARED_LIBS_f3d)
  superbuild_project_add_step("extra-install-sdk"
    COMMAND ${CMAKE_COMMAND} --install <BINARY_DIR> --component sdk
    COMMENT
      "Installing SDK"
    DEPENDEES
      install
  )
endif ()
