superbuild_set_revision(assimp
  URL     "https://github.com/assimp/assimp/archive/refs/tags/v6.0.2.tar.gz"
  DOWNLOAD_NAME assimp-v6.0.2.tar.gz
  URL_MD5 c5a1432214fbe08ddfb230b22d53217a)

superbuild_set_revision(draco
  URL     "https://github.com/google/draco/archive/refs/tags/1.5.7.tar.gz"
  DOWNLOAD_NAME draco-1.5.7.tar.gz
  URL_MD5 b91def257264152be35c62f82f805d25)

# Force embree to 4.2.0 because of
# https://github.com/f3d-app/f3d-superbuild/issues/260
superbuild_set_revision(embree
    URL     "https://www.paraview.org/files/dependencies/embree-4.2.0.tar.gz"
    URL_MD5 9e6abbfb230a2ea07e80fa193ed94186)

superbuild_set_revision(imgui
  URL "https://github.com/ocornut/imgui/archive/refs/tags/v1.92.5.tar.gz"
  DOWNLOAD_NAME imgui-v1.92.5.tar.gz
  URL_MD5 49b9bc2a3afe18bccb790d1c7427dc29)

superbuild_set_revision(occt
  URL     "https://github.com/Open-Cascade-SAS/OCCT/archive/refs/tags/V7_9_3.tar.gz"
  DOWNLOAD_NAME occt-V7_9_3.tar.gz
  URL_MD5 724d6ad98f138b9cda7576679b8bff94)

superbuild_set_revision(openexr
  URL     "https://github.com/AcademySoftwareFoundation/openexr/archive/refs/tags/v3.4.4.tar.gz"
  DOWNLOAD_NAME openexr-v3.4.4.tar.gz
  URL_MD5 ad8587c4a64bf423c387734e85d17432)

superbuild_set_revision(openusd
  URL     "https://github.com/PixarAnimationStudios/OpenUSD/archive/refs/tags/v25.11.tar.gz"
  DOWNLOAD_NAME openusd-v25.11.tar.gz
  URL_MD5 c5d35692ad9809cad046037f1512b1b4)

superbuild_set_revision(openvdb
  URL "https://github.com/AcademySoftwareFoundation/openvdb/archive/refs/tags/v13.0.0.tar.gz"
  DOWNLOAD_NAME openvdb-v13.0.0.tar.gz
  URL_MD5 7a10f529ed12d9e3ed6d3fd50f157378)

superbuild_set_revision(webp
  URL     "https://github.com/webmproject/libwebp/archive/refs/tags/v1.6.0.tar.gz"
  DOWNLOAD_NAME webp-v1.6.0.tar.gz
  URL_MD5 d498caf9323a24ce3ed40b84c22a32cd)

superbuild_set_selectable_source(vtk
  SELECT 9.5.2 DEFAULT
    URL     "https://www.vtk.org/files/release/9.5/VTK-9.5.2.tar.gz"
    URL_MD5 0506164a7118772878bf165927a19cdb
  SELECT git CUSTOMIZABLE
    GIT_REPOSITORY "https://gitlab.kitware.com/vtk/vtk.git"
    GIT_TAG        "origin/master"
  SELECT source CUSTOMIZABLE
    SOURCE_DIR "source-vtk")

superbuild_set_selectable_source(f3d
  SELECT 3.3.0
    URL     "https://github.com/f3d-app/f3d/archive/refs/tags/v3.4.1.tar.gz"
    DOWNLOAD_NAME f3d-v3.4.1.tar.gz
    URL_MD5 034efa26b4234996db2bc1247fe984be
  SELECT git CUSTOMIZABLE DEFAULT
    GIT_REPOSITORY "https://github.com/f3d-app/f3d.git"
    GIT_TAG        "origin/master"
  SELECT source CUSTOMIZABLE
    SOURCE_DIR "source-f3d")
