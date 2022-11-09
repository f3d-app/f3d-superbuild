include(f3d.bundle.common)
set(f3d_appname "${f3d_name}-${f3d_version}.app") # TODO

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

## TODO impossible to implement without a MacOS, will be handled in another PR

#superbuild_apple_create_app(
#  "\${CMAKE_INSTALL_PREFIX}"
#  "${f3d_appname}"
#  "${superbuild_install_location}/Applications/f3d.app/Contents/MacOS/f3d"
#  CLEAN
#  SEARCH_DIRECTORIES "${superbuild_install_location}/lib"
#  ADDITIONAL_LIBRARIES ${additional_libraries})
#
#install(
#  FILES       "${superbuild_install_location}/../superbuild/f3d/src/logo.icns" # TODO
#  DESTINATION "${f3d_appname}/Contents/Resources"
#  COMPONENT   superbuild) # TODO
#install(
#  FILES       "${superbuild_install_location}/Applications/f3d.app/Contents/Info.plist"
#  DESTINATION "${f3d_appname}/Contents"
#  COMPONENT   superbuild) # TODO
