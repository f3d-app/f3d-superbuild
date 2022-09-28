superbuild_add_project(alembic
  LICENSE_FILES
    LICENSE.txt
  DEPENDS imath
  CMAKE_ARGS
    -DUSE_BINARIES=OFF
    -DBUILD_TESTING=OFF
    -DCMAKE_BUILD_TYPE=Release
)
