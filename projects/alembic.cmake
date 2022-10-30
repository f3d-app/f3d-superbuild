set(alembic_lib_install_dir lib)
if (WIN32)
  set(alembic_lib_install_dir bin)
endif (WIN32)

superbuild_add_project(alembic
  LICENSE_FILES
    LICENSE.txt
  DEPENDS imath
  CMAKE_ARGS
    -DALEMBIC_LIB_INSTALL_DIR:PATH=${alembic_lib_install_dir}
    -DUSE_BINARIES=OFF
    -DBUILD_TESTING=OFF
    -DCMAKE_BUILD_TYPE=Release
)
