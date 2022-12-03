## Set CPack vars
include(f3d.bundle.common)

## Package binaries

# Set where library will be found by fixup_bundle.py
set(library_paths "${superbuild_install_location}/bin")

# TODO Add component support in superbuild
# Package the F3D executable
superbuild_windows_install_program("f3d" "bin"
	SEARCH_DIRECTORIES "${library_paths}"
	COMPONENT binaries)

# Package the F3D shell extension
superbuild_windows_install_plugin("F3DShellExtension.dll" "bin" "bin" 
  SEARCH_DIRECTORIES  "${library_paths}"
  COMPONENT binaries)

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
    superbuild_windows_install_plugin("${osprayextra_library}.dll" "bin" "bin"
      SEARCH_DIRECTORIES "${library_paths}"
      COMPONENT binaries)
  endforeach ()
endif ()

## Package F3D resources

# List of individual files to package
set(f3d_resources
    config.json
    logo.ico)

foreach (f3d_resource IN LISTS f3d_resources)
  install(
    FILES       "${superbuild_install_location}/${f3d_resource}"
    DESTINATION "."
    COMPONENT   resources)
endforeach ()

# Package licenses directories
install(
  DIRECTORY   "${superbuild_install_location}/share/licenses"
  DESTINATION "share"
  COMPONENT   resources
  USE_SOURCE_PERMISSIONS)

## Package libf3d SDK

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

install(
  FILES       "${superbuild_install_location}/lib/f3d.lib"
  DESTINATION "lib"
  COMPONENT   sdk)

## NSIS Packaging
if (cpack_generator MATCHES "NSIS")
  set(CPACK_MODULE_PATH "${CMAKE_CURRENT_LIST_DIR}/NSIS")

  set(f3d_ico "${superbuild_install_location}/logo.ico") # TODO add a cmake option in F3D for this

  # For some reason, we need Windows backslashes
  # https://www.howtobuildsoftware.com/index.php/how-do/PNb/cmake-nsis-bmp-cpack-how-to-set-an-icon-in-nsis-install-cmake
  # BMP3 format is also required (recommended size is 150x57)
  set(CPACK_PACKAGE_ICON "${superbuild_install_location}/..//superbuild/f3d/src/resources\\\\logo.bmp") # TODO F3D should install this somewhere
  set(CPACK_NSIS_URL_INFO_ABOUT ${f3d_url})
  set(CPACK_NSIS_MENU_LINKS ${f3d_url} "F3D Website")
  set(CPACK_NSIS_MODIFY_PATH ON)
  set(CPACK_NSIS_MUI_ICON ${f3d_ico})
  set(CPACK_NSIS_MUI_UNIICON ${f3d_ico})
  set(CPACK_NSIS_INSTALLED_ICON_NAME "logo.ico")
  set(CPACK_NSIS_URL_INFO_ABOUT ${f3d_url})
  set(CPACK_NSIS_ENABLE_UNINSTALL_BEFORE_INSTALL ON)
  set(CPACK_NSIS_DISPLAY_NAME "F3D")

  # Include the scripts
  # FileAssociation.nsh, from https://nsis.sourceforge.io/File_Association, has to be installed in NSIS\Include in the system
  set(CPACK_NSIS_EXTRA_PREINSTALL_COMMANDS
    "\
    !include \\\"FileFunc.nsh\\\"\n\
    !include \\\"FileAssociation.nsh\\\"")

  # Create association on install
  set(F3D_REGISTER_LIST "${F3D_FILE_ASSOCIATION_NSIS}")
  list(TRANSFORM F3D_REGISTER_LIST PREPEND "\\\${RegisterExtension} '$INSTDIR\\\\bin\\\\f3d.exe' ")
  list(JOIN F3D_REGISTER_LIST "\n      " F3D_REGISTER_STRING)
  set(CPACK_NSIS_EXTRA_INSTALL_COMMANDS "
  StrCmp $REGISTER_EXTENSIONS \\\"0\\\" doNotRegisterExtensions
  ${F3D_REGISTER_STRING}
  \\\${RefreshShellIcons}
  doNotRegisterExtensions:\n\n")

  # Register thumbnails on install
  set(CPACK_NSIS_EXTRA_INSTALL_COMMANDS "${CPACK_NSIS_EXTRA_INSTALL_COMMANDS}
    ; Register shell extension
    StrCmp $REGISTER_THUMBNAILS \\\"0\\\" doNotRegisterThumbnails
    ExecWait '\\\"$SYSDIR\\\\regsvr32.exe\\\" /s \\\"$INSTDIR\\\\bin\\\\F3DShellExtension.dll\\\"'
    doNotRegisterThumbnails:\n")

  # Remove association on uninstall
  set(F3D_UNREGISTER_LIST "${F3D_FILE_ASSOCIATION_NSIS}")
  list(TRANSFORM F3D_UNREGISTER_LIST PREPEND "\\\${UnRegisterExtension} ")
  list(JOIN F3D_UNREGISTER_LIST "\n      " F3D_UNREGISTER_STRING)
  set(CPACK_NSIS_EXTRA_UNINSTALL_COMMANDS "
          StrCmp $REGISTER_EXTENSIONS \\\"0\\\" doNotUnregisterExtensions
          ${F3D_UNREGISTER_STRING}
          \\\${RefreshShellIcons}
          doNotUnregisterExtensions:\n\n")

  # Remove thumbnails extension on uninstall
  set(CPACK_NSIS_EXTRA_UNINSTALL_COMMANDS "${CPACK_NSIS_EXTRA_UNINSTALL_COMMANDS}
    ; Unregister shell extension
    StrCmp $REGISTER_THUMBNAILS \\\"0\\\" doNotUnregisterThumbnails
    ExecWait '\\\"$SYSDIR\\\\regsvr32.exe\\\" /s /u \\\"$INSTDIR\\\\bin\\\\F3DShellExtension.dll\\\"'
    doNotUnregisterThumbnails:\n")
endif ()
