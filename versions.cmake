superbuild_set_revision(assimp
  URL     "https://github.com/assimp/assimp/archive/refs/tags/v6.0.5.tar.gz"
  DOWNLOAD_NAME assimp-v6.0.5.tar.gz
  URL_MD5 b15787a3bc2f022d01cda9aa712a6681)

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
  URL     "https://github.com/AcademySoftwareFoundation/openexr/archive/refs/tags/v3.4.11.tar.gz"
  DOWNLOAD_NAME openexr-v3.4.11.tar.gz
  URL_MD5 e0c1a315ccffa6f0ae94aa75602d58a7)

superbuild_set_revision(openjph
  URL     "https://github.com/aous72/OpenJPH/archive/refs/tags/0.27.3.tar.gz"
  DOWNLOAD_NAME openjph-0.27.3.tar.gz
  URL_MD5 49f930145e000e85f14fbe5ac2ae4367)

superbuild_set_revision(openusd
  URL     "https://github.com/PixarAnimationStudios/OpenUSD/archive/refs/tags/v26.05.tar.gz"
  DOWNLOAD_NAME openusd-v26.05.tar.gz
  URL_MD5 080e3e471ec56f8493ea4a56a7a2068a)

superbuild_set_revision(openvdb
  URL "https://github.com/AcademySoftwareFoundation/openvdb/archive/refs/tags/v13.0.0.tar.gz"
  DOWNLOAD_NAME openvdb-v13.0.0.tar.gz
  URL_MD5 7a10f529ed12d9e3ed6d3fd50f157378)

# Temporary update until common-superbuild catches up
superbuild_set_revision(pybind11
  URL     "https://github.com/pybind/pybind11/archive/refs/tags/v3.0.4.tar.gz"
  DOWNLOAD_NAME pybind11-3.0.4.tar.gz
  URL_MD5 933fa1b6b1fe34c9945ecb3fe67f5c4b)

superbuild_set_revision(webp
  URL     "https://github.com/webmproject/libwebp/archive/refs/tags/v1.6.0.tar.gz"
  DOWNLOAD_NAME webp-v1.6.0.tar.gz
  URL_MD5 d498caf9323a24ce3ed40b84c22a32cd)

superbuild_set_revision(webifc
  URL     "https://github.com/ThatOpen/engine_web-ifc/archive/refs/tags/0.77.tar.gz"
  DOWNLOAD_NAME webifc-0.77.tar.gz
  URL_MD5 b9fc504150899f3894741759f9bb8f41)

superbuild_set_selectable_source(vtk
  SELECT 9.6.1 DEFAULT
    URL     "https://www.vtk.org/files/release/9.6/VTK-9.6.1.tar.gz"
    URL_MD5 056ea89e37f4f9b3a6305e5d67515ccc
  SELECT git CUSTOMIZABLE
    GIT_REPOSITORY "https://gitlab.kitware.com/vtk/vtk.git"
    GIT_TAG        "origin/master"
  SELECT source CUSTOMIZABLE
    SOURCE_DIR "source-vtk")

superbuild_set_selectable_source(f3d
  SELECT 3.5.0
    URL     "https://github.com/f3d-app/f3d/archive/refs/tags/v3.5.0.tar.gz"
    DOWNLOAD_NAME f3d-v3.5.0.tar.gz
    URL_MD5 d64edb8ee5193a652183e01b404a993f
  SELECT git CUSTOMIZABLE DEFAULT
    GIT_REPOSITORY "https://github.com/f3d-app/f3d.git"
    GIT_TAG        "origin/master"
  SELECT source CUSTOMIZABLE
    SOURCE_DIR "source-f3d")

## Temporary bump from f3d-superbuild until
## https://github.com/f3d-app/f3d-superbuild/issues/305 is fixed

superbuild_set_revision(alembic
  # https://github.com/alembic/alembic/releases
  URL     "https://www.paraview.org/files/dependencies/alembic-1.8.10.tar.gz"
  URL_MD5 73d2ea132e334781978d1aeb2961be05)
