include(f3d.bundle.common)

set(library_paths
  "${superbuild_install_location}/lib")

# Package the F3D executable
superbuild_windows_install_program("${superbuild_install_location}/bin/f3d" "bin"
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
      superbuild_windows_install_plugin("${osprayextra_library}.dll"
        "bin"
        "bin"
        SEARCH_DIRECTORIES "${superbuild_install_location}/bin")
    endforeach ()
  endforeach ()
endif ()
