# Set suffix to be used for generating archives. This ensures that the package
# files have decent names that we can directly upload to the release page.
set(package_suffix_items)

if (APPLE)
  list(APPEND package_suffix_items
    "macOS")
else ()
  list(APPEND package_suffix_items
    "${CMAKE_SYSTEM_NAME}")
endif ()

list(LENGTH CMAKE_OSX_ARCHITECTURES osx_arch_count)

if ("${osx_arch_count}" GREATER 1)
  message(FATAL_ERROR "Universal macOS build is not supported yet")
endif()

if (NOT APPLE OR "${osx_arch_count}" EQUAL 0)
  if ("${CMAKE_SYSTEM_PROCESSOR}" MATCHES "^(x86_64||AMD64)$")
    list(APPEND package_suffix_items "x86_64")
  else()
    list(APPEND package_suffix_items "${CMAKE_SYSTEM_PROCESSOR}")
  endif()
else ()
  list(APPEND package_suffix_items "${CMAKE_OSX_ARCHITECTURES}")
endif()

if (egl_enabled)
  list(APPEND package_suffix_items
    "headless")
endif()

if (ospray_enabled)
  list(APPEND package_suffix_items
    "raytracing")
endif()

string(REPLACE ";" "-" f3d_package_suffix "${package_suffix_items}")
