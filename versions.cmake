superbuild_set_revision(assimp
  URL     "https://github.com/assimp/assimp/archive/refs/tags/v6.0.2.tar.gz"
  DOWNLOAD_NAME assimp-v6.0.2.tar.gz
  URL_MD5 c5a1432214fbe08ddfb230b22d53217a)

superbuild_set_revision(draco
  URL     "https://github.com/google/draco/archive/refs/tags/1.5.7.tar.gz"
  DOWNLOAD_NAME draco-1.5.7.tar.gz
  URL_MD5 b91def257264152be35c62f82f805d25)

# Force embree to 4.2.0 when using OSPRay 2.12.0 because of
# https://github.com/f3d-app/f3d-superbuild/issues/260
superbuild_set_selectable_source(embree
  # https://github.com/embree/embree/releases
  SELECTS_WITH ospray
  SELECT 2.7.1
    URL     "https://www.paraview.org/files/dependencies/embree-v3.13.1.tar.gz"
    URL_MD5 71453f1e9af48a95090112e493982898
  SELECT 2.12.0
    URL     "https://www.paraview.org/files/dependencies/embree-4.2.0.tar.gz"
    URL_MD5 9e6abbfb230a2ea07e80fa193ed94186)

superbuild_set_revision(imgui
  URL "https://github.com/ocornut/imgui/archive/refs/tags/v1.92.1.tar.gz"
  DOWNLOAD_NAME imgui-v1.92.1.tar.gz
  URL_MD5 68a3126462b7f2ebcd9b0d0c7dda93ad)

superbuild_set_revision(occt
  URL     "https://github.com/Open-Cascade-SAS/OCCT/archive/refs/tags/V7_9_1.tar.gz"
  DOWNLOAD_NAME occt-V7_9_1.tar.gz
  URL_MD5 56898327dd2d8aa36221048def0715e2)

superbuild_set_revision(openexr
  URL     "https://github.com/AcademySoftwareFoundation/openexr/archive/refs/tags/v3.3.4.tar.gz"
  DOWNLOAD_NAME openexr-v3.3.4.tar.gz
  URL_MD5 50c69abdabe667a0a821f28d1fa34f0f)

superbuild_set_revision(openusd
  URL     "https://github.com/PixarAnimationStudios/OpenUSD/archive/refs/tags/v25.05.01.tar.gz"
  DOWNLOAD_NAME openusd-v25.05.01.tar.gz
  URL_MD5 f7f6f265639b16f44d8ee9104fbf34bb)

superbuild_set_revision(openvdb
  URL "https://github.com/AcademySoftwareFoundation/openvdb/archive/refs/tags/v12.0.1.tar.gz"
  DOWNLOAD_NAME openvdb-v12.0.1.tar.gz
  URL_MD5 e9b07f14aadb7da50d12154f9234763d)

superbuild_set_selectable_source(vtk
  SELECT 9.5.0 DEFAULT
    URL     "https://www.vtk.org/files/release/9.5/VTK-9.5.0.tar.gz"
    URL_MD5 3c2543fae68ac131955a5517c1e47514
  SELECT git CUSTOMIZABLE
    GIT_REPOSITORY "https://gitlab.kitware.com/vtk/vtk.git"
    GIT_TAG        "origin/master"
  SELECT source CUSTOMIZABLE
    SOURCE_DIR "source-vtk")

superbuild_set_selectable_source(f3d
  SELECT 3.2.0
    URL     "https://github.com/f3d-app/f3d/archive/refs/tags/v3.2.0.tar.gz"
    DOWNLOAD_NAME f3d-v3.2.0.tar.gz
    URL_MD5 724b47588505fdf032dcb60026392d5e
  SELECT git CUSTOMIZABLE DEFAULT
    GIT_REPOSITORY "https://github.com/f3d-app/f3d.git"
    GIT_TAG        "origin/master"
  SELECT source CUSTOMIZABLE
    SOURCE_DIR "source-f3d")
