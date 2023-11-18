set(vtk_raytracing_enabled NO)
if (ospray_enabled)
  set(vtk_raytracing_enabled YES)
endif ()

set(vtk_ioexodus_enabled NO)
if (exodus_enabled)
  set(vtk_ioexodus_enabled YES)
endif ()

set(vtk_platform_dependencies)
if (UNIX)
  if (NOT APPLE)
    list(APPEND vtk_platform_dependencies egl)
  endif ()
endif ()

set(vtk_smp_type "Sequential")
set(vtk_smp_enable_sequential OFF)
if (tbb_enabled)
  set(vtk_smp_type "TBB")
else ()
  set(vtk_smp_enable_sequential ON)
endif ()

superbuild_add_project(vtk
  BUILD_SHARED_LIBS_INDEPENDENT
  LICENSE_FILES
    Copyright.txt
  DEPENDS cxx11
  DEPENDS_OPTIONAL tbb ospray exodus ${vtk_platform_dependencies}
  CMAKE_ARGS
    -DCMAKE_MACOSX_RPATH=ON
    -DVTKOSPRAY_ENABLE_DENOISER=${ospray_enabled}
    -DVTK_BUILD_TESTING=OFF
    -DVTK_DEFAULT_RENDER_WINDOW_HEADLESS=${egl_enabled}
    -DVTK_ENABLE_LOGGING=OFF
    -DVTK_ENABLE_WRAPPING=OFF
    -DVTK_GROUP_ENABLE_Rendering=DEFAULT
    -DVTK_GROUP_ENABLE_StandAlone=DEFAULT
    -DVTK_LEGACY_REMOVE=ON
    -DVTK_MODULE_ENABLE_VTK_CommonSystem=YES
    -DVTK_MODULE_ENABLE_VTK_FiltersGeneral=YES
    -DVTK_MODULE_ENABLE_VTK_FiltersGeometry=YES
    -DVTK_MODULE_ENABLE_VTK_IOCityGML=YES
    -DVTK_MODULE_ENABLE_VTK_IOExodus:STRING=${vtk_ioexodus_enabled}
    -DVTK_MODULE_ENABLE_VTK_IOGeometry=YES
    -DVTK_MODULE_ENABLE_VTK_IOImage=YES
    -DVTK_MODULE_ENABLE_VTK_IOImport=YES
    -DVTK_MODULE_ENABLE_VTK_IOPLY=YES
    -DVTK_MODULE_ENABLE_VTK_IOParallel=YES
    -DVTK_MODULE_ENABLE_VTK_IOXML=YES
    -DVTK_MODULE_ENABLE_VTK_ImagingCore=YES
    -DVTK_MODULE_ENABLE_VTK_ImagingHybrid=YES
    -DVTK_MODULE_ENABLE_VTK_InteractionStyle=YES
    -DVTK_MODULE_ENABLE_VTK_InteractionWidgets=YES
    -DVTK_MODULE_ENABLE_VTK_RenderingAnnotation=YES
    -DVTK_MODULE_ENABLE_VTK_RenderingCore=YES
    -DVTK_MODULE_ENABLE_VTK_RenderingExternal=YES
    -DVTK_MODULE_ENABLE_VTK_RenderingLabel=YES
    -DVTK_MODULE_ENABLE_VTK_RenderingOpenGL2=YES
    -DVTK_MODULE_ENABLE_VTK_RenderingRayTracing:STRING=${vtk_raytracing_enabled}
    -DVTK_MODULE_ENABLE_VTK_RenderingVolumeOpenGL2=YES
    -DVTK_MODULE_ENABLE_VTK_TestingCore=YES
    -DVTK_OPENGL_HAS_EGL=${egl_enabled}
    -DVTK_SMP_ENABLE_SEQUENTIAL=${vtk_smp_enable_sequential}
    -DVTK_SMP_ENABLE_STDTHREAD=OFF
    -DVTK_SMP_ENABLE_TBB=${tbb_enabled}
    -DVTK_SMP_IMPLEMENTATION_TYPE=${vtk_smp_type}
    -DVTK_VERSIONED_INSTALL=OFF
)
