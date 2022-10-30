include(f3d.bundle.common)

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
      superbuild_unix_install_module("${lib_filename}"
        "lib"
        "lib"
        LOADER_PATHS  "${library_paths}"
        LOCATION      "lib"
        HAS_SYMLINKS)
    endforeach ()
  endforeach ()
endif ()

# Package F3D resources
set(f3d_resource_dirs
    applications
    bash-completion
    f3d
    fish
    icons
    licenses
    metainfo
    mime
    thumbnailers
    zsh)

foreach (f3d_resource_dir IN LISTS f3d_resource_dirs)
  install(
    DIRECTORY   "${superbuild_install_location}/share/${f3d_resource_dir}"
    DESTINATION "share"
    COMPONENT   resources
    USE_SOURCE_PERMISSIONS)
endforeach ()

install(
  FILES   "${superbuild_install_location}/share/man/man1/f3d.1.gz"
  DESTINATION "share/man/man1"
  COMPONENT   resources)

install(
  FILES   "${superbuild_install_location}/share/doc/f3d/README.md"
  DESTINATION "share/doc/f3d/"
  COMPONENT   resources)

# Package libf3d SDK
install(
  DIRECTORY   "${superbuild_install_location}/lib/cmake/f3d"
  DESTINATION "lib/cmake"
  COMPONENT   sdk
  USE_SOURCE_PERMISSIONS)

install(
  DIRECTORY   "${superbuild_install_location}/include/f3d"
  DESTINATION "include"
  COMPONENT   sdk
  USE_SOURCE_PERMISSIONS)
