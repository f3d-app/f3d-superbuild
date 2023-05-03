set(alembic_lib_install_dir lib)
if (WIN32)
  set(alembic_lib_install_dir bin)
endif ()

if (NOT BUILD_SHARED_LIBS_imath STREQUAL "<same>")
  set(alembic_ilmbase_link_static NOT ${BUILD_SHARED_LIBS_imath})
else ()
  set(alembic_ilmbase_link_static NOT ${BUILD_SHARED_LIBS})
endif ()

if (NOT BUILD_SHARED_LIBS_alembic STREQUAL "<same>")
  set(alembic_shared_libs ${BUILD_SHARED_LIBS_alembic})
else ()
  set(alembic_shared_libs ${BUILD_SHARED_LIBS})
endif ()

superbuild_add_project(alembic
  BUILD_SHARED_LIBS_INDEPENDENT
  LICENSE_FILES
    LICENSE.txt
  DEPENDS imath
  CMAKE_ARGS
    -DALEMBIC_ILMBASE_LINK_STATIC=${alembic_ilmbase_link_static}
    -DALEMBIC_LIB_INSTALL_DIR=${alembic_lib_install_dir}
    -DALEMBIC_SHARED_LIBS=${alembic_shared_libs}
    -DCMAKE_BUILD_TYPE=Release
    -DCMAKE_INSTALL_RPATH=<INSTALL_DIR>/lib
    -DCMAKE_MACOSX_RPATH=OFF
    -DUSE_BINARIES=OFF
    -DUSE_TESTS=OFF
)
