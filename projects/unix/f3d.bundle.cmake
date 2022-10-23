set(CPACK_PACKAGE_NAME "F3D-TODO")

set(library_paths
  "${superbuild_install_location}/lib")

# Package the F3D executable
superbuild_unix_install_program("${superbuild_install_location}/bin/f3d" "lib"
  SEARCH_DIRECTORIES  "${library_paths}")


# Package supplemental ospray libraries that may be loaded dynamically
if (ospray_enabled)
  set(osprayextra_libraries
    openvkl_module_cpu_device
    openvkl_module_cpu_device_4
    openvkl_module_cpu_device_8
    openvkl_module_cpu_device_16
    ospray_module_denoiser
    ospray_module_ispc)

  foreach (osprayextra_library IN LISTS osprayextra_libraries)
    file(GLOB lib_filenames
      RELATIVE "${superbuild_install_location}/lib"
      "${superbuild_install_location}/lib/lib${osprayextra_library}.so.[1-9]")

    foreach (lib_filename IN LISTS lib_filenames)
      message(WARNING ${lib_filename})
      superbuild_unix_install_module("${lib_filename}"
        "lib"
        "lib"
        LOADER_PATHS  "${library_paths}"
        LOCATION      "lib"
        HAS_SYMLINKS)
    endforeach ()
  endforeach ()
endif ()
