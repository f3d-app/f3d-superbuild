set(f3d_extract_dir "${CMAKE_CURRENT_BINARY_DIR}/test-extraction")
if (WIN32)
  set(generator "ZIP")
  set(f3d_exe "${f3d_extract_dir}/bin/f3d.exe")
  set(f3d_console_exe "${f3d_extract_dir}/bin/f3d-console.exe")
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

function(f3d_add_test)

  cmake_parse_arguments(F3D_ADD_TEST "" "NAME;FILE;BACKEND" "ARGS" ${ARGN})

  if (F3D_ADD_TEST_BACKEND)
    list(APPEND F3D_ADD_TEST_ARGS "--rendering-backend=${F3D_ADD_TEST_BACKEND}")
  else ()
    # TODO what about COCOA then ?
    list(APPEND F3D_ADD_TEST_ARGS "--rendering-backend=${F3D_TESTING_FORCE_RENDERING_BACKEND}")
  endif ()

  add_test(
    NAME    "f3d-exec-${F3D_ADD_TEST_NAME}"
    COMMAND "${f3d_exe}"
            "${CMAKE_SOURCE_DIR}/testing/data/${F3D_ADD_TEST_FILE}"
            "--resolution=300,300"
            "--output=${CMAKE_BINARY_DIR}/Testing/Temporary/${F3D_ADD_TEST_NAME}.png"
            "--reference=${CMAKE_SOURCE_DIR}/testing/baselines/${F3D_ADD_TEST_NAME}.png"
            ${F3D_ADD_TEST_ARGS})
  set_tests_properties(f3d-exec-${F3D_ADD_TEST_NAME}
    PROPERTIES
      LABELS  "F3D"
      DEPENDS "f3d-exec-exists")
endfunction ()

function (f3d_add_console_test name file)
  add_test(
    NAME    "f3d-console-exec-${name}"
    COMMAND "${f3d_console_exe}"
            "${CMAKE_SOURCE_DIR}/testing/data/${file}"
            "--resolution=300,300"
            "--output=${CMAKE_BINARY_DIR}/Testing/Temporary/${name}.png"
            "--reference=${CMAKE_SOURCE_DIR}/testing/baselines/${name}.png"
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
  # Disabled until https://github.com/f3d-app/f3d/pull/2407 is fixed
  # f3d_add_sdk_test(TestExternal "${CMAKE_SOURCE_DIR}/testing/sdk/test_external" test_external)
endif ()

# F3D test

if (UNIX OR APPLE)
  superbuild_test_loadable_modules("f3d" "install" "${CMAKE_BINARY_DIR}/install")
  superbuild_test_loadable_modules("f3d" "${generator}" "${f3d_extract_dir}" )
endif ()

# Check f3d executable exists by using md5sum command
add_test(
  NAME    "f3d-exec-exists"
  COMMAND "${CMAKE_COMMAND}" -E md5sum ${f3d_exe})
set_tests_properties(f3d-exec-exists
  PROPERTIES
    LABELS  "F3D"
    DEPENDS "extract-f3d-${generator}")

# Use f3d executable to ensure dependecies can be loaded and renders correctly
f3d_add_test(NAME TestSimple FILE cow.vtp)
f3d_add_test(NAME TestSimpleColor FILE dragon.vtu ARGS --colormap-file=viridis)
f3d_add_test(NAME TestThumbnail FILE dragon.vtu ARGS --config=thumbnail)

if (WIN32)
  f3d_add_test(NAME TestRenderingWGL FILE dragon.vtu BACKEND wgl)

  add_test(
    NAME    "f3d-console-exec-exists"
    COMMAND "${CMAKE_COMMAND}" -E md5sum ${f3d_console_exe})
  set_tests_properties(f3d-console-exec-exists
    PROPERTIES
      LABELS  "F3D"
      DEPENDS "extract-f3d-${generator}")

  f3d_add_console_test(TestSimple cow.vtp)
endif ()

if (UNIX AND NOT APPLE)
  # XXX: This test requires a Xorg server running
  f3d_add_test(NAME TestRenderingGLX FILE dragon.vtu BACKEND glx)
endif ()

if (NOT APPLE)
  f3d_add_test(NAME TestSplat FILE small.splat)
endif ()

if (egl_enabled)
  # XXX: Once Ubuntu 22.04 is used for CI, this test should use coloring
  f3d_add_test(NAME TestRenderingHeadlessEGL FILE cow.vtp BACKEND egl)
endif ()

if (osmesa_enabled)
  f3d_add_test(NAME TestRenderingHeadlessOSMESA FILE dragon.vtu BACKEND osmesa)
endif ()

if (alembic_enabled)
  f3d_add_test(NAME TestAlembic FILE suzanne.abc)
endif ()

if (assimp_enabled)
  f3d_add_test(NAME TestAssimp FILE duck.fbx)
endif ()

if (draco_enabled)
  f3d_add_test(NAME TestDraco FILE suzanne.drc ARGS --coloring-component=0)
endif ()

if (occt_enabled)
  f3d_add_test(NAME TestOCCT FILE f3d.stp)
endif ()

if (ospray_enabled)
  # This baseline is incorrect, caused by https://github.com/f3d-app/f3d/issues/483
  f3d_add_test(NAME TestOSPRay FILE dragon.vtu ARGS -rd --raytracing-samples=4)
endif ()

if (openusd_enabled)
  # --camera-view-angle needed because of https://github.com/f3d-app/f3d/issues/3375
  f3d_add_test(NAME TestUSD FILE primitives.usda ARGS --camera-view-angle=29.3333)
endif ()

if (f3dhdf_enabled)
  f3d_add_test(NAME TestHDF FILE blob.vtkhdf)
endif ()

if (openvdb_enabled)
  f3d_add_test(NAME TestVDB FILE icosahedron.vdb)
endif ()

if (pdal_enabled)
  # PDAL use a plugin mechanism, each format should be checked
  # High threshold needed as rendering points is driver dependant
  # --camera-view-angle sometimes needed because of https://github.com/f3d-app/f3d/issues/3375
  f3d_add_test(NAME TestPDALLAS FILE warsaw_small.las ARGS --reference-threshold=0.1)
  f3d_add_test(NAME TestPDALLAZ FILE simple.laz)
  f3d_add_test(NAME TestPDALBPF FILE simple-extra.bpf)
  f3d_add_test(NAME TestPDALBIN FILE 20020715-time-color.bin ARGS --reference-threshold=0.21)
  f3d_add_test(NAME TestPDALCSD FILE sample.csd ARGS --camera-view-angle=27.4444)
  f3d_add_test(NAME TestPDALPCD FILE autzen-utm.pcd ARGS --reference-threshold=0.1)
  f3d_add_test(NAME TestPDALPTX FILE 1.2-with-color.ptx)
  f3d_add_test(NAME TestPDALQI FILE 10-word.qi)
  f3d_add_test(NAME TestPDALSBET FILE autzen_trim.sbet)
  f3d_add_test(NAME TestPDALSLPK FILE SMALL_AUTZEN_LAS_All.slpk)
endif ()

if (webifc_enabled)
  f3d_add_test(NAME TestWebIFC FILE IfcOpenHouse_IFC4.ifc ARGS --reference-threshold=0.06)
endif ()
