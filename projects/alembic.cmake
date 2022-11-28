set(alembic_lib_install_dir lib)
if (WIN32)
  set(alembic_lib_install_dir bin)
endif ()

superbuild_add_project(alembic
  LICENSE_FILES
    LICENSE.txt
  DEPENDS imath
  CMAKE_ARGS
    -DALEMBIC_LIB_INSTALL_DIR:PATH=${alembic_lib_install_dir}
    -DUSE_BINARIES=OFF
    -DUSE_TESTS=OFF
    -DCMAKE_BUILD_TYPE=Release
    -DCMAKE_MACOSX_RPATH=OFF
)

superbuild_apply_patch(alembic disable-macosx-rpath
  "Disable macosx rpath force")
