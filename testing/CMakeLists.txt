set(f3d_extract_dir "${CMAKE_CURRENT_BINARY_DIR}/test-extraction")
if (WIN32)
  set(generator "ZIP")
  set(f3d_exe "${f3d_extract_dir}/bin/f3d.exe")
elseif (APPLE)
  set(generator "DragNDrop")
  include(f3d-appname)
  set(f3d_exe "${f3d_extract_dir}/${f3d_appname}/Contents/MacOS/f3d")
else ()
  set(generator "TGZ")
  set(f3d_exe "${f3d_extract_dir}/bin/f3d")
endif ()

include(f3d.info)
include(f3d-version)
include(f3d.suffix)
set(f3d_package_file_name "${f3d_name}-${f3d_version_full}-${f3d_package_suffix}")
superbuild_add_extract_test("f3d" "${f3d_package_file_name}" "${generator}" "${f3d_extract_dir}" LABELS "F3D")

function (f3d_add_test name file)
  add_test(
    NAME    "f3d-exec-${name}"
    COMMAND "${f3d_exe}"
            "${CMAKE_SOURCE_DIR}/testing/data/${file}"
            "--resolution=300,300"
            "--output=${CMAKE_BINARY_DIR}/Testing/Temporary/${name}.png"
            "--ref=${CMAKE_SOURCE_DIR}/testing/baselines/${name}.png"
            ${ARGN})
  set_tests_properties(f3d-exec-${name}
    PROPERTIES
      LABELS  "F3D"
      DEPENDS "f3d-exec-exists")
endfunction ()

function (f3d_add_sdk_test name folder exe)
  add_test(
    NAME    "f3d-sdk-${name}"
    COMMAND ${CMAKE_COMMAND}
            -Dtest_sdk_name=${name}
            -Dtest_sdk_dir=${folder}
            -Dtest_sdk_exe=${exe}
            -Dsuperbuild_build_type=${CMAKE_BUILD_TYPE}
            -Dsuperbuild_generator=${CMAKE_GENERATOR}
            -Df3d_install_dir=${f3d_extract_dir}
            -P ${CMAKE_SOURCE_DIR}/testing/scripts/f3d.test.sdk.cmake)
  set_tests_properties(f3d-sdk-${name}
    PROPERTIES
      LABELS  "F3D"
      DEPENDS "extract-f3d-${generator}")
endfunction ()

# SDK Tests
# These tests check the SDK can be built, linked against and loaded
# But no actual test is performed
if (NOT APPLE AND BUILD_SHARED_LIBS_f3d)
  f3d_add_sdk_test(TestEngine "${CMAKE_SOURCE_DIR}/testing/sdk/test_engine" test_engine)
  f3d_add_sdk_test(TestRendering "${CMAKE_SOURCE_DIR}/testing/sdk/test_rendering" test_rendering)
  f3d_add_sdk_test(TestExternal "${CMAKE_SOURCE_DIR}/testing/sdk/test_external" test_external)
endif ()

# F3D test

# Check f3d executable exists by using md5sum command
add_test(
  NAME    "f3d-exec-exists"
  COMMAND "${CMAKE_COMMAND}" -E md5sum ${f3d_exe})
set_tests_properties(f3d-exec-exists
  PROPERTIES
    LABELS  "F3D"
    DEPENDS "extract-f3d-${generator}")

# Use f3d executable to ensure dependecies can be loaded and renders correctly
f3d_add_test(TestSimple cow.vtp)
f3d_add_test(TestSimpleColor dragon.vtu --colormap-file=viridis)
f3d_add_test(TestThumbnail dragon.vtu --config=thumbnail)
f3d_add_test(TestRenderingHeadlessEGL dragon.vtu --rendering-backend=egl)
f3d_add_test(TestRenderingHeadlessOSMESA dragon.vtu --rendering-backend=osmesa)

if (WIN32)
  f3d_add_test(TestRenderingWGL dragon.vtu --rendering-backend=wgl)
endif ()

if (UNIX AND NOT APPLE)
  f3d_add_test(TestRenderingGLX dragon.vtu --rendering-backend=glx)
endif ()

if (NOT APPLE)
  f3d_add_test(TestSplat small.splat)
endif ()

if (alembic_enabled)
  f3d_add_test(TestAlembic suzanne.abc)
endif ()

if (assimp_enabled)
  f3d_add_test(TestAssimp duck.fbx)
endif ()

if (draco_enabled)
  f3d_add_test(TestDraco suzanne.drc)
endif ()

if (occt_enabled)
  # This test is needed because cell coloring does not work on macOS CI: https://github.com/f3d-app/f3d/issues/792
  f3d_add_test(TestOCCT f3d.stp --scalar-coloring=false)
  f3d_add_test(TestOCCTColoring f3d.stp)
endif ()

if (ospray_enabled)
  # This baseline is incorrect, caused by https://github.com/f3d-app/f3d/issues/483
  f3d_add_test(TestOSPRay dragon.vtu -rd --samples=4)
endif ()

if (openusd_enabled)
  f3d_add_test(TestUSD primitives.usda)
endif ()

if (openvdb_enabled)
  f3d_add_test(TestVDB icosahedron.vdb)
endif ()
