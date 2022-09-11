set(embree_BUILD_ISA "DEFAULT" CACHE STRING "ISAs to build Embree for")
mark_as_advanced(embree_BUILD_ISA)

#by default, turn off very old and very new SIMD instruction sets
#because they are problematic on our dashboards
if (APPLE)
  set(embree_allow_sse2 "-DEMBREE_ISA_SSE2:BOOL=OFF")
  set(embree_allow_sse42 "-DEMBREE_ISA_SSE42:BOOL=OFF")
endif()
set(embree_allow_skx "-DEMBREE_ISA_AVX512SKX:BOOL=OFF")

#build the list of SIMD instruction sets we will enable
set(embree_isa_args)
if(NOT (embree_BUILD_ISA STREQUAL "DEFAULT"))
  if(embree_BUILD_ISA STREQUAL "ALL")
    set(embree_BUILD_ISA SSE2 SSE42 AVX AVX2 AVX512KNL AVX512SKX)
  endif()
  list(APPEND embree_isa_args -DEMBREE_MAX_ISA:BOOL=NONE)
  foreach(isa IN LISTS embree_BUILD_ISA)
    list(APPEND embree_isa_args -DEMBREE_ISA_${isa}:BOOL=ON)
    if (isa MATCHES "SSE2")
      set(embree_allow_sse2)
    endif()
    if (isa MATCHES "SSE42")
      set(embree_allow_sse42)
    endif()
    if (isa MATCHES "AVX512SKX")
      set(embree_allow_skx)
    endif()
  endforeach()
endif()

superbuild_add_project(embree
  DEPENDS ispc tbb cxx11
  LICENSE_FILES
    LICENSE.txt
  CMAKE_ARGS
    ${embree_isa_args}
    ${embree_allow_sse2}
    ${embree_allow_sse42}
    ${embree_allow_skx}
    -DBUILD_TESTING:BOOL=OFF
    -DEMBREE_ISPC_EXECUTABLE:PATH=<INSTALL_DIR>/bin/ispc
    -DEMBREE_GEOMETRY_HAIR:BOOL=ON
    -DEMBREE_GEOMETRY_LINES:BOOL=OFF
    -DEMBREE_GEOMETRY_QUADS:BOOL=OFF
    -DEMBREE_GEOMETRY_SUBDIV:BOOL=OFF
    -DEMBREE_TUTORIALS:BOOL=OFF
    -DCMAKE_INSTALL_LIBDIR:STRING=lib)

if (MSVC_VERSION EQUAL 1900)
  superbuild_append_flags(cxx_flags "-d2SSAOptimizer-" PROJECT_ONLY)
endif()
