if (UNIX AND NOT APPLE)
  superbuild_append_flags(ld_flags
    "-Wl,-rpath,${superbuild_install_location}/lib"
    PROJECT_ONLY)
endif ()

superbuild_add_project(rkcommon
  LICENSE_FILES
    LICENSE.txt
  DEPENDS cxx11 tbb
  CMAKE_ARGS
     -DBUILD_TESTING:BOOL=OFF
     -DCMAKE_INSTALL_LIBDIR:STRING=lib
     -DCMAKE_INSTALL_NAME_DIR:PATH=<INSTALL_DIR>/lib
     -DINSTALL_DEPS:BOOL=OFF
)
