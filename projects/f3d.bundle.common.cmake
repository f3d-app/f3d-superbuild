set(f3d_name F3D)
set(f3d_description "F3D - A fast and minimalist 3D viewer")
set(f3d_url "https://f3d-app.github.io/f3d/")

# Define f3d_version_full and other vars
include(f3d-version)

set(CPACK_PACKAGE_NAME "${f3d_name}")
set(CPACK_PACKAGE_VERSION "${f3d_version_full}")
set(CPACK_PACKAGE_INSTALL_DIRECTORY  "${f3d_name}")
set(CPACK_PACKAGE_VENDOR "${f3d_name}-app")
set(CPACK_PACKAGE_DESCRIPTION_SUMMARY "${f3d_description}")
set(CPACK_PACKAGE_DESCRIPTION_FILE ${readme_path})
set(CPACK_PACKAGE_HOMEPAGE_URL ${f3d_url})
set(CPACK_PACKAGE_CHECKSUM MD5)
set(CPACK_PACKAGE_EXECUTABLES f3d f3d)
set(CPACK_RESOURCE_FILE_README ${readme_path})
set(CPACK_RESOURCE_FILE_LICENSE "${superbuild_install_location}/share/licenses/f3d/LICENSE")
set(CPACK_CREATE_DESKTOP_LINKS f3d)
set(CPACK_STRIP_FILES TRUE)
set(CPACK_THREADS 0)
