set(vtk_raytracing_enabled NO)
if (ospray_enabled)
  set(vtk_raytracing_enabled YES)
endif ()

set(vtk_ioexodus_enabled NO)
if (exodus_enabled)
  set(vtk_ioexodus_enabled YES)
endif ()

set(vtk_ioopenvdb_enabled NO)
if (openvdb_enabled)
  set(vtk_ioopenvdb_enabled YES)
endif ()

# XXX: Not listed as an optional dependencies
# as egl is a use system project
set(vtk_egl_enabled NO)
if (egl_enabled)
  set(vtk_egl_enabled YES)
endif ()

set(vtk_use_x NO)
if (UNIX AND NOT APPLE)
  set(vtk_use_x YES)
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
  DEPENDS_OPTIONAL tbb ospray exodus openvdb
  CMAKE_ARGS
    -DVTKOSPRAY_ENABLE_DENOISER:BOOL=${ospray_enabled}
    -DVTK_BUILD_TESTING:BOOL=OFF
    -DVTK_ENABLE_LOGGING:BOOL=OFF
    -DVTK_ENABLE_WRAPPING:BOOL=OFF
    -DVTK_GROUP_ENABLE_Rendering:STRING=DEFAULT
    -DVTK_GROUP_ENABLE_StandAlone:STRING=DEFAULT
    -DVTK_LEGACY_REMOVE:BOOL=ON
    -DVTK_MODULE_ENABLE_VTK_CommonSystem:STRING=YES
    -DVTK_MODULE_ENABLE_VTK_FiltersGeneral:STRING=YES
    -DVTK_MODULE_ENABLE_VTK_FiltersGeometry:STRING=YES
    -DVTK_MODULE_ENABLE_VTK_IOCityGML:STRING=YES
    -DVTK_MODULE_ENABLE_VTK_IOExodus:STRING=${vtk_ioexodus_enabled}
    -DVTK_MODULE_ENABLE_VTK_IOGeometry:STRING=YES
    -DVTK_MODULE_ENABLE_VTK_IOImage:STRING=YES
    -DVTK_MODULE_ENABLE_VTK_IOImport:STRING=YES
    -DVTK_MODULE_ENABLE_VTK_IOPLY:STRING=YES
    -DVTK_MODULE_ENABLE_VTK_IOOpenVDB:STRING=${vtk_ioopenvdb_enabled}
    -DVTK_MODULE_ENABLE_VTK_IOParallel:STRING=YES
    -DVTK_MODULE_ENABLE_VTK_IOXML:STRING=YES
    -DVTK_MODULE_ENABLE_VTK_ImagingCore:STRING=YES
    -DVTK_MODULE_ENABLE_VTK_ImagingHybrid:STRING=YES
    -DVTK_MODULE_ENABLE_VTK_InteractionStyle:STRING=YES
    -DVTK_MODULE_ENABLE_VTK_InteractionWidgets:STRING=YES
    -DVTK_MODULE_ENABLE_VTK_RenderingAnnotation:STRING=YES
    -DVTK_MODULE_ENABLE_VTK_RenderingCore:STRING=YES
    -DVTK_MODULE_ENABLE_VTK_RenderingLabel:STRING=YES
    -DVTK_MODULE_ENABLE_VTK_RenderingOpenGL2:STRING=YES
    -DVTK_MODULE_ENABLE_VTK_RenderingRayTracing:STRING=${vtk_raytracing_enabled}
    -DVTK_MODULE_ENABLE_VTK_RenderingVolumeOpenGL2:STRING=YES
    -DVTK_MODULE_ENABLE_VTK_TestingCore:STRING=YES
    -DVTK_OPENGL_HAS_EGL:BOOL=${vtk_egl_enabled}
    -DVTK_SMP_ENABLE_SEQUENTIAL:BOOL=${vtk_smp_enable_sequential}
    -DVTK_SMP_ENABLE_STDTHREAD:BOOL=OFF
    -DVTK_SMP_ENABLE_TBB:BOOL=${tbb_enabled}
    -DVTK_SMP_IMPLEMENTATION_TYPE:STRING=${vtk_smp_type}
    -DVTK_USE_X:BOOL=${vtk_use_x}
    -DVTK_VERSIONED_INSTALL:BOOL=OFF
)
