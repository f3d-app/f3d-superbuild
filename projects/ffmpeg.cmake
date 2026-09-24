if (NOT BUILD_SHARED_LIBS_ffmpeg STREQUAL "<same>")
  set(ffmpeg_build_shared ${BUILD_SHARED_LIBS_ffmpeg})
else ()
  set(ffmpeg_build_shared ${BUILD_SHARED_LIBS})
endif ()

if (ffmpeg_build_shared)
  set(ffmpeg_shared_args --enable-shared --disable-static)
else ()
  set(ffmpeg_shared_args --disable-shared --enable-static)
endif ()

set(ffmpeg_c_flags ${superbuild_c_flags})
set(ffmpeg_ld_flags ${superbuild_ld_flags})

# Needed to find openh264
if (UNIX)
  string(PREPEND ffmpeg_ld_flags "-Wl,-rpath,<INSTALL_DIR>/lib ")
endif ()

set(ffmpeg_extra_args "")
if (WIN32)
  set(ffmpeg_extra_args --cc=cl --toolchain=msvc)
elseif (APPLE)
  set(ffmpeg_extra_args --cc=clang --install-name-dir=@rpath)
endif ()

superbuild_add_project(ffmpeg
  BUILD_SHARED_LIBS_INDEPENDENT
  DEPENDS bash nasm openh264 pkgconf
  LICENSE_FILES
    LICENSE.md
    COPYING.LGPLv2.1
  CONFIGURE_COMMAND
    "${BASH_EXECUTABLE}"
    <SOURCE_DIR>/configure
      --prefix=<INSTALL_DIR>
      --disable-all
      --disable-autodetect
      --enable-avcodec
      --enable-avutil
      --enable-libopenh264
      --enable-encoder=libopenh264
      --pkg-config=${superbuild_pkgconf}
      ${ffmpeg_extra_args}
      ${ffmpeg_shared_args}
      --extra-cflags=${ffmpeg_c_flags}
      --extra-ldflags=${ffmpeg_ld_flags}
  BUILD_COMMAND
    $(MAKE)
  INSTALL_COMMAND
    $(MAKE) install
  BUILD_IN_SOURCE 1
  PROCESS_ENVIRONMENT
    PKG_CONFIG_ALLOW_SYSTEM_CFLAGS 1 # Required to find dependencies when using pkgconf built in superbuild
    PKG_CONFIG_ALLOW_SYSTEM_LIBS 1  # Required to find dependencies when using pkgconf built in superbuild
    MSYS2_ARG_CONV_EXCL "*" # Required when using make on Windows
  )

# There is a bug in ffmpeg configure when generating dependency files on Windows with MSVC.
# Dependency files are not necessary for full build so they are patched out.
# https://trac.ffmpeg.org/ticket/9043
superbuild_apply_patch(ffmpeg skip-windows-depcmd
  "Skip dependency command on Windows")
