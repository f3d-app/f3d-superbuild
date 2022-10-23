# TODO Recover from somewhere ?
set(f3d_name F3D)
set(f3d_version 1.3.1)
set(f3d_description "F3D - A fast and minimalist 3D viewer")

set(CPACK_PACKAGE_NAME "${f3d_name}")
set(CPACK_PACKAGE_VERSION "${f3d_version}") # separate ? TODO
set(CPACK_PACKAGE_INSTALL_DIRECTORY  "${f3d_name}")
set(CPACK_PACKAGE_VENDOR "${f3d_name}-app")
set(CPACK_PACKAGE_DESCRIPTION_SUMMARY "${f3d_description}")
#set(CPACK_PACKAGE_DESCRIPTION_FILE "${CMAKE_SOURCE_DIR}/README.md") TODO
#set(CPACK_RESOURCE_FILE_README "${CMAKE_SOURCE_DIR}/README.md") TODO
#set(CPACK_RESOURCE_FILE_LICENSE "${CMAKE_SOURCE_DIR}/LICENSE.md") TODO
#set(CPACK_PACKAGE_EXECUTABLES f3d f3d) Should not be needed
set(CPACK_CREATE_DESKTOP_LINKS f3d) # Needed ?

set(CPACK_DEBIAN_PACKAGE_MAINTAINER "Whisley <whisley.santos@gmail.com>")
set(CPACK_DEBIAN_PACKAGE_DEPENDS "libbsd0, libxdmcp6, libglvnd0, libxcb1, libc6, libgcc1, libstdc++6, libopengl0, libglx0, libx11-6")



