## Set CPack vars
set(f3d_license_path "share/licenses")
include(f3d.bundle.common)

## Package binaries

# Set where library will be found by fixup_bundle.py
set(library_paths "${superbuild_install_location}/bin")

# Package the F3D executable
superbuild_windows_install_program("f3d" "bin"
	SEARCH_DIRECTORIES "${library_paths}" COMPONENT "")

# Package the F3D console executable
superbuild_windows_install_program("f3d-console" "bin"
	SEARCH_DIRECTORIES "${library_paths}" COMPONENT "")

# Package the F3D shell extension
superbuild_windows_install_plugin("F3DShellExtension.dll" "bin" "bin"
  SEARCH_DIRECTORIES  "${library_paths}" COMPONENT "")

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
      SEARCH_DIRECTORIES "${library_paths}" COMPONENT "")
  endforeach ()
endif ()

# OpenUSD plugin descriptors
if (openusd_enabled)
  f3d_package_usd_plugins(DESTINATION "bin")
endif()

## Package F3D resources

# Package all licenses
f3d_package_all_licenses()

# Package resources
install(
  DIRECTORY   "${superbuild_install_location}/share/f3d/"
  DESTINATION "share/f3d/"
  USE_SOURCE_PERMISSIONS)

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

install(
  FILES       "${superbuild_install_location}/lib/f3d.lib"
  DESTINATION "lib"
  OPTIONAL)

## NSIS Generator specific
if (cpack_generator MATCHES "NSIS")

  # NSIS Resources
  file(COPY
      "${superbuild_source_directory}/resources/logo.ico"
      "${superbuild_source_directory}/resources/logotype64.bmp"
    DESTINATION "${superbuild_install_location}/share/f3d")

  set(CPACK_MODULE_PATH "${CMAKE_CURRENT_LIST_DIR}/NSIS")

  set(f3d_ico_relative "share/f3d/logo.ico")
  set(f3d_ico "${superbuild_install_location}/${f3d_ico_relative}")

  # For some reason, we need Windows backslashes
  # https://www.howtobuildsoftware.com/index.php/how-do/PNb/cmake-nsis-bmp-cpack-how-to-set-an-icon-in-nsis-install-cmake
  # BMP3 format is also required (recommended size is 150x57)
  set(CPACK_PACKAGE_ICON "${superbuild_install_location}\\\\share\\\\f3d\\\\logotype64.bmp")
  set(CPACK_NSIS_URL_INFO_ABOUT ${f3d_url})
  set(CPACK_NSIS_MENU_LINKS ${f3d_url} "F3D Website")
  set(CPACK_NSIS_MODIFY_PATH ON)
  set(CPACK_NSIS_MUI_ICON ${f3d_ico})
  set(CPACK_NSIS_MUI_UNIICON ${f3d_ico})
  set(CPACK_NSIS_INSTALLED_ICON_NAME ${f3d_ico_relative})
  set(CPACK_NSIS_URL_INFO_ABOUT ${f3d_url})
  set(CPACK_NSIS_ENABLE_UNINSTALL_BEFORE_INSTALL ON)
  set(CPACK_NSIS_DISPLAY_NAME "F3D")

  # Include the scripts
  # FileAssociation.nsh, from https://nsis.sourceforge.io/File_Association, has to be installed in NSIS\Include in the system
  set(CPACK_NSIS_EXTRA_PREINSTALL_COMMANDS
    "\
    !include \\\"FileFunc.nsh\\\"\n\
    !include \\\"FileAssociation.nsh\\\"")

  # Read F3D plugin json files to recover the file associations
  set(F3D_REGISTER_LIST "")
  file(GLOB plugin_json_files ${superbuild_install_location}/share/f3d/plugins/*.json)
  foreach(plugin_json_file ${plugin_json_files})
    file(READ ${plugin_json_file} plugin_json_string)
    string(JSON readers GET ${plugin_json_string} readers)
    string(JSON readers_length LENGTH ${readers})
    math(EXPR readers_length "${readers_length}-1")
    foreach(reader_idx RANGE ${readers_length})
      string(JSON reader GET ${readers} ${reader_idx})
      string(JSON description GET ${reader} description)
      string(JSON extensions GET ${reader} extensions)
      string(JSON extensions_length LENGTH ${extensions})
      math(EXPR extensions_length "${extensions_length}-1")
      foreach(extension_idx RANGE ${extensions_length})
        string(JSON extension GET ${extensions} ${extension_idx})
        list(APPEND F3D_REGISTER_LIST "'.${extension}' '${description}'")
      endforeach()
    endforeach()
  endforeach()

  # Create association on install
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
