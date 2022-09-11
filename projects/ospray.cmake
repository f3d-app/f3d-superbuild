set(ospray_isa_default "ALL")
if (DEFINED OSPRAY_BUILD_ISA)
  message(WARNING "The OSPRAY_BUILD_ISA setting is deprecated in favor of ospray_BUILD_ISA.")
  set(ospray_isa_default "${OSPRAY_BUILD_ISA}")
endif ()

set(ospray_BUILD_ISA "${ospray_isa_default}"
  CACHE STRING "Target ISA for OSPRay (SSE, AVX, AVX2, AVX512KNL, AVX512SKX, or ALL).")
mark_as_advanced(ospray_BUILD_ISA)
set_property(CACHE ospray_BUILD_ISA PROPERTY STRINGS SSE AVX AVX2 AVX512KNL AVX512SKX ALL)

superbuild_add_project(ospray
  DEPENDS
    ispc tbb cxx11 embree ospraymaterials openimagedenoise rkcommon openvkl
  DEPENDS_OPTIONAL ospraymodulempi snappy mpi
  LICENSE_FILES
    LICENSE.txt
  CMAKE_ARGS
    -DOSPRAY_ISPC_DIRECTORY:PATH=<INSTALL_DIR>/bin
    -DCMAKE_INSTALL_NAME_DIR:PATH=<INSTALL_DIR>/lib
    -DCMAKE_INSTALL_LIBDIR:STRING=lib
    -DOSPRAY_BUILD_ISA:STRING=${ospray_BUILD_ISA}
    -DOSPRAY_APPS_EXAMPLES:BOOL=OFF
    -DOSPRAY_APPS_TESTING:BOOL=OFF
    -DOSPRAY_ENABLE_APPS:BOOL=OFF
    -DOSPRAY_MODULE_DENOISER:BOOL=ON
    -DOSPRAY_MODULE_MPI:BOOL=${ospraymodulempi_enabled}
    -DOSPRAY_MPI_BUILD_TUTORIALS:BOOL=OFF
)

superbuild_add_extra_cmake_args(
  -DOSPRAY_INSTALL_DIR:PATH=<INSTALL_DIR>)
