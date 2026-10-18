superbuild_add_project_python(meson
  PACKAGE
    meson
  DEPENDS
    pythonsetuptools
    ninja
  LICENSE_FILES
    COPYING
  )

if (WIN32)
  set(meson_command
    "<INSTALL_DIR>/Python/Scripts/meson.exe")
elseif(APPLE AND USE_SYSTEM_python3)
  set(meson_command
    "<INSTALL_DIR>/opt/homebrew/bin/meson")
else()
  set(meson_command
    "<INSTALL_DIR>/bin/meson")
endif ()
