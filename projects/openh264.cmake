if (NOT BUILD_SHARED_LIBS_openh264 STREQUAL "<same>")
  set(openh264_build_shared ${BUILD_SHARED_LIBS_openh264})
else ()
  set(openh264_build_shared ${BUILD_SHARED_LIBS})
endif ()

set(openh264_default_library shared)
if (NOT openh264_build_shared)
  set(openh264_default_library static)
endif ()

superbuild_add_project(openh264
  BUILD_SHARED_LIBS_INDEPENDENT
  DEPENDS meson nasm ninja
  LICENSE_FILES
    LICENSE
  SPDX_LICENSE_IDENTIFIER
    BSD-2-Clause
  SPDX_COPYRIGHT_TEXT
    "Copyright (c) 2013, Cisco Systems"
  CONFIGURE_COMMAND
    ${meson_command}
      setup
      build
      --prefix=<INSTALL_DIR>
      --libdir=lib
      --buildtype=release
      --default-library=${openh264_default_library}
      -Db_ndebug=true
      -Dtests=disabled
  BUILD_COMMAND
    ${superbuild_ninja_command} -C build
  INSTALL_COMMAND
    ${superbuild_ninja_command} -C build install
  BUILD_IN_SOURCE 1
)
