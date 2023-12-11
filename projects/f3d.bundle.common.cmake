# Define f3d_name and other vars
include(f3d.info)

# Define f3d_version_full and other vars
include(f3d-version)

# Define f3d_package_suffix
include(f3d.suffix)

set(CPACK_PACKAGE_NAME "${f3d_name}")
set(CPACK_PACKAGE_VERSION "${f3d_version_full}")
set(CPACK_PACKAGE_INSTALL_DIRECTORY  "${f3d_name}")
set(CPACK_PACKAGE_VENDOR "${f3d_name}-app")
set(CPACK_PACKAGE_DESCRIPTION_SUMMARY "${f3d_description}")
set(CPACK_PACKAGE_HOMEPAGE_URL ${f3d_url})
set(CPACK_PACKAGE_CHECKSUM MD5)
set(CPACK_PACKAGE_EXECUTABLES f3d f3d)
set(CPACK_RESOURCE_FILE_LICENSE "${superbuild_install_location}/share/licenses/f3d/LICENSE.md")
set(CPACK_CREATE_DESKTOP_LINKS f3d)
set(CPACK_STRIP_FILES TRUE)
set(CPACK_THREADS 0)

set(CPACK_PACKAGE_FILE_NAME "${CPACK_PACKAGE_NAME}-${f3d_version_full}-${f3d_package_suffix}")

set(superbuild_bundle_system_libraries_component "")
set(superbuild_bundle_default_component "")

# Manage licenses packaging
function (f3d_package_all_licenses)
  set(license_projects "${enabled_projects}")

  foreach (project IN LISTS license_projects)
    if (NOT ${project}_built_by_superbuild)
      list(REMOVE_ITEM license_projects ${project})
    endif ()
  endforeach ()

  # Do not install license of non-packaged projects
  list(REMOVE_ITEM license_projects
   ffi
   ispc
   ospraymaterials
   png
   python3
   sqlite
   xz
    )

  foreach (project IN LISTS license_projects)
    if (EXISTS "${superbuild_install_location}/share/licenses/${project}")
      install(
        DIRECTORY   "${superbuild_install_location}/share/licenses/${project}"
        DESTINATION "${f3d_license_path}")
    else ()
      message(FATAL_ERROR "${superbuild_install_location}/share/licenses/${project} does not exist, aborting.")
    endif ()
  endforeach ()
endfunction ()

# Manage OpenUSD plugin descriptors
function (f3d_package_usd_plugins)
  cmake_parse_arguments(USD_PLUGINS "" "DESTINATION" "" ${ARGN})

  if (NOT DEFINED USD_PLUGINS_DESTINATION)
    message(FATAL_ERROR "f3d_package_usd_plugins is called without DESTINATION")
  endif ()

  install(
    DIRECTORY   "${superbuild_install_location}/lib/usd"
    DESTINATION "${USD_PLUGINS_DESTINATION}"
    USE_SOURCE_PERMISSIONS)
endfunction ()