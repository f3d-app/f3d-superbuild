set(alembic_lib_install_dir lib)
if (WIN32)
  set(alembic_lib_install_dir bin)
endif ()

superbuild_add_project(alembic
  LICENSE_FILES
    LICENSE.txt
  DEPENDS imath
  CMAKE_ARGS
    -DALEMBIC_LIB_INSTALL_DIR=${alembic_lib_install_dir}
    -DALEMBIC_SHARED_LIBS=OFF
    -DUSE_BINARIES=OFF
    -DUSE_TESTS=OFF
    -DCMAKE_BUILD_TYPE=Release
    -DCMAKE_MACOSX_RPATH=OFF
    -DCMAKE_INSTALL_RPATH=<INSTALL_DIR>/lib
)
