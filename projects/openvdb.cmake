if (NOT BUILD_SHARED_LIBS_openvdb STREQUAL "<same>")
  set(openvdb_build_shared ${BUILD_SHARED_LIBS_openvdb})
else ()
  set(openvdb_build_shared ${BUILD_SHARED_LIBS})
endif ()
if (openvdb_build_shared)
  set(openvdb_build_static OFF)
else ()
  set(openvdb_build_static ON)
endif ()

# CMAKE_MSVC_RUNTIME_LIBRARY is needed because of https://github.com/AcademySoftwareFoundation/openvdb/issues/1131
superbuild_add_project(openvdb
  BUILD_SHARED_LIBS_INDEPENDENT
  DEPENDS tbb cxx17 blosc zlib lz4 zstd
  LICENSE_FILES
    LICENSE
  CMAKE_ARGS
    -DCMAKE_INSTALL_LIBDIR:PATH=lib
    -DCMAKE_MSVC_RUNTIME_LIBRARY:STRING=MultiThreadedDLL
    -DDISABLE_DEPENDENCY_VERSION_CHECKS:BOOL=ON
    -DOPENVDB_BUILD_VDB_PRINT:BOOL=OFF
    -DOPENVDB_CORE_SHARED:BOOL=${openvdb_build_shared}
    -DOPENVDB_CORE_STATIC:BOOL=${openvdb_build_static}
    -DOPENVDB_USE_DELAYED_LOADING:BOOL=OFF
    -DUSE_BLOSC:BOOL=ON
    -DUSE_CCACHE:BOOL=OFF
    -DUSE_EXPLICIT_INSTANTIATION:BOOL=OFF
    -DUSE_ZLIB:BOOL=ON)

# OPENVDB_USE_STATIC_LIBS is needed because FindOpenVDB.cmake is not smart enough to find it out itself
# CMAKE_MODULE_PATH is needed because of https://github.com/AcademySoftwareFoundation/openvdb/issues/1160
superbuild_add_extra_cmake_args(
  -DCMAKE_MODULE_PATH:PATH=<INSTALL_DIR>/lib/cmake/OpenVDB
  -DOPENVDB_USE_STATIC_LIBS:BOOL=${openvdb_build_static}
)

# https://github.com/AcademySoftwareFoundation/openvdb/issues/1741
# https://github.com/AcademySoftwareFoundation/openvdb/issues/1740
superbuild_apply_patch(openvdb remove-not-needed-cmake-modules
  "Remove not needed cmake modules")

# https://github.com/AcademySoftwareFoundation/openvdb/issues/1630
superbuild_apply_patch(openvdb fix-visible-dependencies-link
  "Fix visible dependencies link")

# https://github.com/AcademySoftwareFoundation/openvdb/issues/1630
superbuild_apply_patch(openvdb remove-lib-prefix-static
 "Remove lib prefix with static lib")
