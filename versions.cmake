superbuild_set_revision(embree
  URL     "https://www.paraview.org/files/dependencies/embree-v3.13.1.tar.gz"
  URL_MD5 71453f1e9af48a95090112e493982898)

superbuild_set_revision(ospray
  URL     "https://www.paraview.org/files/dependencies/ospray-v2.7.1.tar.gz"
  URL_MD5 e027ca7a5119300a0c94c3f9be38b58d)

superbuild_set_revision(ospraymaterials
  URL     "https://www.paraview.org/files/data/OSPRayMaterials-0.3.tar.gz"
  URL_MD5 d256c17f70890d3477e90d35bf814c25)

superbuild_set_revision(openimagedenoise
  URL     "https://www.paraview.org/files/dependencies/oidn-1.4.1.src.tar.gz"
  URL_MD5 df4007b0ab93b1c41cdf223b075d01c0)

superbuild_set_revision(rkcommon
  URL     "https://www.paraview.org/files/dependencies/rkcommon-v1.7.0.tar.gz"
  URL_MD5 1bd26e5aea9b1c4873fe8b8cec9a1d28)

superbuild_set_revision(openvkl
  URL     "https://www.paraview.org/files/dependencies/openvkl-v1.0.1.tar.gz"
  URL_MD5 c6a9a222df0e7f21b49ea8081b509171)

if (WIN32)
  set(ispc_suffix "windows.zip")
  set(ispc_md5 22d1e9fd03427b8e8a9d75ce56cfa495)
elseif (APPLE)
  set(ispc_suffix "macOS.tar.gz")
  set(ispc_md5 0ae980be5d319b38592c6ef5596c305d)
else()
  set(ispc_suffix "linux.tar.gz")
  set(ispc_md5 4665c577541003e31c8ce0afd64b6952)
endif()
superbuild_set_revision(ispc
  URL     "https://www.paraview.org/files/dependencies/ispc-v1.16.1-${ispc_suffix}"
  URL_MD5 "${ispc_md5}")

superbuild_set_revision(vtk
  URL     "https://www.vtk.org/files/release/9.2/VTK-9.2.0.rc2.tar.gz"
  URL_MD5 f1238c0ad6ed76de03a0f0d570fa3db9)
