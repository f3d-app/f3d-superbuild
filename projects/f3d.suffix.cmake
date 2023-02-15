# Set suffix to be used for generating archives. This ensures that the package
# files have decent names that we can directly upload to the release page.
set(package_suffix_items)

if (ospray_enabled)
  list(APPEND package_suffix_items
    "raytracing")
endif()

if (APPLE)
  list(APPEND package_suffix_items
    "macOS")
else ()
  list(APPEND package_suffix_items
    "${CMAKE_SYSTEM_NAME}")
endif ()

list(APPEND package_suffix_items
  "${CMAKE_SYSTEM_PROCESSOR}")

string(REPLACE ";" "-" f3d_package_suffix "${package_suffix_items}")
