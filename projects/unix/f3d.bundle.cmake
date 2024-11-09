## Set CPack vars
set(f3d_license_path "share/licenses")
include(f3d.bundle.common)

## Package binaries

# Set where library will be found by fixup_bundle.py
set(library_paths "${superbuild_install_location}/lib")

# Package the F3D executable
superbuild_unix_install_program("${superbuild_install_location}/bin/f3d" "lib" SEARCH_DIRECTORIES "${library_paths}")

# Package supplemental ospray libraries that may be loaded dynamically
if (ospray_enabled)
  set(osprayextra_libraries
    openvkl_module_cpu_device
    ospray_module_denoiser)

  foreach (osprayextra_library IN LISTS osprayextra_libraries)
    file(GLOB lib_filenames
      RELATIVE "${superbuild_install_location}/lib"
      "${superbuild_install_location}/lib/lib${osprayextra_library}.so*")

    foreach (lib_filename IN LISTS lib_filenames)

      # Do not install symlink manually
      if(IS_SYMLINK "${superbuild_install_location}/lib/${lib_filename}")
        continue ()
      endif ()

      superbuild_unix_install_module("${lib_filename}"
        "lib"
        "lib"
        LOADER_PATHS  "${library_paths}"
        LOCATION      "lib"
        HAS_SYMLINKS)
    endforeach ()
  endforeach ()
endif ()

# OpenUSD plugin descriptors
if (openusd_enabled)
  f3d_package_usd_plugins(DESTINATION "lib")
endif()

## Package F3D resources

# Package all licenses
f3d_package_all_licenses()

# List of directories to package
set(f3d_resource_dirs
    applications
    bash-completion
    f3d
    fish
    icons
    metainfo
    mime
    thumbnailers
    zsh)

foreach (f3d_resource_dir IN LISTS f3d_resource_dirs)
  install(
    DIRECTORY   "${superbuild_install_location}/share/${f3d_resource_dir}"
    DESTINATION "share"
    USE_SOURCE_PERMISSIONS)
endforeach ()

# Individual files to package
install(
  FILES   "${superbuild_install_location}/share/man/man1/f3d.1.gz"
  DESTINATION "share/man/man1")

## Package libf3d SDK

install(
  DIRECTORY   "${superbuild_install_location}/lib/cmake/f3d"
  DESTINATION "lib/cmake"
  USE_SOURCE_PERMISSIONS
  OPTIONAL)

install(
  DIRECTORY   "${superbuild_install_location}/include/f3d"
  DESTINATION "include"
  USE_SOURCE_PERMISSIONS
  OPTIONAL)

## Deb Generator specific
if (cpack_generator MATCHES "DEB")
  set(CPACK_DEBIAN_PACKAGE_HOMEPAGE ${f3d_url})
  set(CPACK_DEBIAN_PACKAGE_ARCHITECTURE "amd64")
  set(CPACK_DEBIAN_PACKAGE_MAINTAINER "Whisley <whisley.santos@gmail.com>")
  set(CPACK_DEBIAN_PACKAGE_DEPENDS "libbsd0, libxdmcp6, libglvnd0, libxcb1, libc6, libgcc1, libstdc++6, libopengl0, libx11-6, libegl1, libglx0, libosmesa6")
endif ()  
