# Utility to determine F3D app name
# Sets up a scoped variable named `f3d_appname`.
include(f3d.info)
include(f3d-version)
set(name_suffix "")
if (f3d_version_branch)
  set(name_suffix "-${f3d_version_branch}")
endif ()
set(f3d_appname "${f3d_name}${name_suffix}-${f3d_version_major}.${f3d_version_minor}.${f3d_version_patch}${f3d_version_suffix}.app")
