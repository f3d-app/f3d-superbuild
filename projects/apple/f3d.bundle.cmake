## Set CPack vars
include(f3d-appname)
set(f3d_license_path "${f3d_appname}/Contents/Resources/licenses")
include(f3d.bundle.common)

## Package binaries

# Package supplemental ospray libraries that may be loaded dynamically
set(additional_libraries)
if (ospray_enabled)
  set(osprayextra_libraries
    openvkl_module_cpu_device
    openvkl_module_cpu_device_4
    openvkl_module_cpu_device_8
    openvkl_module_cpu_device_16
    ospray_module_denoiser
    ospray_module_ispc)

  foreach (osprayextra_library IN LISTS osprayextra_libraries)
    if (EXISTS "${superbuild_install_location}/lib/lib${osprayextra_library}.dylib")
      list(APPEND additional_libraries
        "${superbuild_install_location}/lib/lib${osprayextra_library}.dylib")
    endif ()
  endforeach ()
endif ()

# Bundle F3D and all binaries
superbuild_apple_create_app(
  "\${CMAKE_INSTALL_PREFIX}"
  "${f3d_appname}"
  "${superbuild_install_location}/f3d.app/Contents/MacOS/f3d"
  CLEAN
  SEARCH_DIRECTORIES "${superbuild_install_location}/lib"
  ADDITIONAL_LIBRARIES ${additional_libraries})

# Package Info.plist
install(
  FILES       "${superbuild_install_location}/f3d.app/Contents/Info.plist"
  DESTINATION "${f3d_appname}/Contents")

# OpenUSD plugin descriptors
if (openusd_enabled)
  f3d_package_usd_plugins(DESTINATION "${f3d_appname}/Contents/plugin")
endif()

## Package F3D resources

# Package all licenses
f3d_package_all_licenses()

# Package resources
install(
  DIRECTORY   "${superbuild_install_location}/f3d.app/Contents/Resources"
  DESTINATION "${f3d_appname}/Contents"
  USE_SOURCE_PERMISSIONS)

## DragNDrop Generator specific
if (cpack_generator MATCHES "DragNDrop")
  set(CPACK_PACKAGE_ICON "${superbuild_install_location}/f3d.app/Contents/Resources/logo.icns")
endif()
