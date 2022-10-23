superbuild_add_project(f3d
  LICENSE_FILES
    LICENSE
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
    -DCMAKE_BUILD_TYPE=Release
    -DF3D_INSTALL_DEFAULT_CONFIGURATION_FILE=ON
    -DF3D_INSTALL_DEFAULT_CONFIGURATION_FILE_IN_PREFIX=ON
)
