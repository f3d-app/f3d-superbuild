# Define f3d_name and other vars
include(f3d.info)

# Define f3d_version_full and other vars
include(f3d-version)

set(CPACK_PACKAGE_NAME "${f3d_name}")
set(CPACK_PACKAGE_VERSION "${f3d_version_full}")
set(CPACK_PACKAGE_INSTALL_DIRECTORY  "${f3d_name}")
set(CPACK_PACKAGE_VENDOR "${f3d_name}-app")
set(CPACK_PACKAGE_DESCRIPTION_SUMMARY "${f3d_description}")
set(CPACK_PACKAGE_HOMEPAGE_URL ${f3d_url})
set(CPACK_PACKAGE_CHECKSUM MD5)
set(CPACK_PACKAGE_EXECUTABLES f3d f3d)
set(CPACK_RESOURCE_FILE_LICENSE "${superbuild_install_location}/share/licenses/f3d/LICENSE")
set(CPACK_CREATE_DESKTOP_LINKS f3d)
set(CPACK_STRIP_FILES TRUE)
set(CPACK_THREADS 0)

set(superbuild_bundle_system_librairies_component "system")
