superbuild_add_project(f3d
  LICENSE_FILES
    LICENSE
  DEPENDS vtk
  CMAKE_ARGS
    -Werror=dev
    -Werror=deprecated
    --warn-uninitialized
    -DF3D_STRICT_BUILD=ON
    -DF3D_MODULE_EXTERNAL_RENDERING=ON
#    -DF3D_MODULE_OCCT=ON
#    -DF3D_MODULE_ASSIMP=ON
#    -DF3D_MODULE_ALEMBIC=ON
    -DF3D_MODULE_RAYTRACING=ON
    -DF3D_PYTHON_BINDINGS=ON
    -DCMAKE_BUILD_TYPE=Release
    -DF3D_INSTALL_DEFAULT_CONFIGURATION_FILE=ON
    -DF3D_INSTALL_DEFAULT_CONFIGURATION_FILE_IN_PREFIX=ON
)
