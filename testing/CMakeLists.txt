set(f3d_extract_dir "${CMAKE_CURRENT_BINARY_DIR}/f3d/test-extraction")
if (WIN32)
  set(generator "ZIP")
  set(f3d_exe "${f3d_extract_dir}/bin/f3d.exe")
elseif (APPLE)
#  set(generator "DragNDrop")
#  include(f3d-appname)
#  set(f3d_exe "${paraview_extract_dir}/${paraview_appname}/Contents/MacOS/f3d")
else ()
  set(generator "TGZ")
  set(f3d_exe "${f3d_extract_dir}/bin/f3d")
endif ()

include(f3d.info)
include(f3d-version)
set(glob_prefix "${f3d_name}-${f3d_version_full}*")
superbuild_add_extract_test("f3d" "${glob_prefix}" "${generator}" "${f3d_extract_dir}" LABELS "F3D")

function (f3d_add_test name file)
  add_test(
    NAME    "f3d-${name}"
    COMMAND "${f3d_exe}"
            "${CMAKE_SOURCE_DIR}/testing/data/${file}"
            "--resolution=300,300"
            "--output=${CMAKE_BINARY_DIR}/Testing/Temporary/${name}.png"
            "--ref=${CMAKE_SOURCE_DIR}/testing/baselines/${name}.png"
            ${ARGN})
  set_tests_properties(f3d-${name}
    PROPERTIES
      LABELS  "F3D"
      DEPENDS "extract-f3d-${generator}")
endfunction ()

f3d_add_test("TestSimple" "cow.vtp")
f3d_add_test("TestSimpleColor" "dragon.vtu")

if (alembic_enabled)
  f3d_add_test("TestAlembic" "suzanne.abc")
endif ()

if (assimp_enabled)
  f3d_add_test("TestAssimp" "slime.fbx")
endif ()

if (occt_enabled)
  f3d_add_test("TestOCCT" "cube.stp")
endif ()

if (ospray_enabled)
  # This baseline is incorrect, caused by https://github.com/f3d-app/f3d/issues/483
  f3d_add_test("TestOSPray" "dragon.vtu" "-rd" "--samples=4")
endif ()
