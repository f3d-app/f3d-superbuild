superbuild_add_project(pybind11
  DEPENDS cxx11
  LICENSE_FILES
    LICENSE
  CMAKE_ARGS
    -DPYBIND11_TEST:BOOL=OFF)
