superbuild_set_revision(assimp
  URL     "https://github.com/assimp/assimp/archive/refs/tags/v5.4.2.tar.gz"
  DOWNLOAD_NAME assimp-v5.4.2.tar.gz
  URL_MD5 1bdc63f5f0b45683c16e339f7f3a0f2c)

superbuild_set_revision(draco
  URL     "https://github.com/google/draco/archive/refs/tags/1.5.6.tar.gz"
  DOWNLOAD_NAME draco-1.5.7.tar.gz
  URL_MD5 dbe3a9e286ee5b79016470349d78b2a3)

superbuild_set_revision(occt
  URL     "https://github.com/Open-Cascade-SAS/OCCT/archive/refs/tags/V7_7_2.tar.gz"
  DOWNLOAD_NAME occt-V7_7_2.tar.gz
  URL_MD5 21d56d4f96eb6fdc65435ea559b6d19c)

superbuild_set_revision(openexr
  URL     "https://github.com/AcademySoftwareFoundation/openexr/archive/refs/tags/v3.2.4.tar.gz"
  DOWNLOAD_NAME openexr-v3.2.4.tar.gz
  URL_MD5 83b23b937b3a76fd37680422f41b81b7)

superbuild_set_revision(openusd
  URL     "https://github.com/PixarAnimationStudios/OpenUSD/archive/refs/tags/v24.11.tar.gz"
  DOWNLOAD_NAME openusd-v24.11.tar.gz
  URL_MD5 f31b5a37817c5dd81be5b49ae819fc64)

superbuild_set_revision(openvdb
  URL "https://github.com/AcademySoftwareFoundation/openvdb/archive/refs/tags/v11.0.0.tar.gz"
  DOWNLOAD_NAME openvdb-v11.0.0.tar.gz
  URL_MD5 025f4fc4db58419341a4991f1a16174a)

superbuild_set_revision(imgui
  URL "https://github.com/ocornut/imgui/archive/refs/tags/v1.91.5.tar.gz"
  DOWNLOAD_NAME imgui-v1.91.5.tar.gz
  URL_MD5 264b2c35eaa1ab1595eb9afe080b4e1a)

superbuild_set_selectable_source(vtk
  SELECT 9.4.1 DEFAULT
    URL     "https://www.vtk.org/files/release/9.4/VTK-9.4.1.tar.gz"
    URL_MD5 2c1b4a1fff031a35e4331a7782908d29
  SELECT git CUSTOMIZABLE
    GIT_REPOSITORY "https://gitlab.kitware.com/vtk/vtk.git"
    GIT_TAG        "origin/master"
  SELECT source CUSTOMIZABLE
    SOURCE_DIR "source-vtk")

superbuild_set_selectable_source(f3d
  SELECT 2.5.1
    URL     "https://github.com/f3d-app/f3d/archive/refs/tags/v2.5.1.tar.gz"
    DOWNLOAD_NAME f3d-v2.5.1.tar.gz
    URL_MD5 4aeba0f3a3427cb0f1d2cf28bd0838e7
  SELECT git CUSTOMIZABLE DEFAULT
    GIT_REPOSITORY "https://github.com/f3d-app/f3d.git"
    GIT_TAG        "origin/master"
  SELECT source CUSTOMIZABLE
    SOURCE_DIR "source-f3d")
