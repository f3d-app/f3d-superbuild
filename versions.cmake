superbuild_set_revision(assimp
  URL     "https://github.com/assimp/assimp/archive/refs/tags/v5.4.3.tar.gz"
  DOWNLOAD_NAME assimp-v5.4.3.tar.gz
  URL_MD5 fd64a9a57a3d81940ba7fc4a3a946502)

superbuild_set_revision(draco
  URL     "https://github.com/google/draco/archive/refs/tags/1.5.7.tar.gz"
  DOWNLOAD_NAME draco-1.5.7.tar.gz
  URL_MD5 b91def257264152be35c62f82f805d25)

superbuild_set_revision(occt
  URL     "https://github.com/Open-Cascade-SAS/OCCT/archive/refs/tags/V7_9_0.tar.gz"
  DOWNLOAD_NAME occt-V7_9_0.tar.gz
  URL_MD5 6cefc45e7a430b9c9f7c92f2210ce1a2)

superbuild_set_revision(openexr
  URL     "https://github.com/AcademySoftwareFoundation/openexr/archive/refs/tags/v3.3.2.tar.gz"
  DOWNLOAD_NAME openexr-v3.3.2.tar.gz
  URL_MD5 0ca7b46575537ff495d9914166aafa65)

superbuild_set_revision(openusd
  URL     "https://github.com/PixarAnimationStudios/OpenUSD/archive/refs/tags/v25.02a.tar.gz"
  DOWNLOAD_NAME openusd-v25.02a.tar.gz
  URL_MD5 96ac0d38398b6a32ab09dfda0f639196)

superbuild_set_revision(openvdb
  URL "https://github.com/AcademySoftwareFoundation/openvdb/archive/refs/tags/v12.0.1.tar.gz"
  DOWNLOAD_NAME openvdb-v12.0.1.tar.gz
  URL_MD5 e9b07f14aadb7da50d12154f9234763d)

superbuild_set_revision(imgui
  URL "https://github.com/ocornut/imgui/archive/refs/tags/v1.91.9b.tar.gz"
  DOWNLOAD_NAME imgui-v1.91.9b.tar.gz
  URL_MD5 753efbcac27275c9dcf9c5da0abec626)

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
