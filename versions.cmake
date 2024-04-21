superbuild_set_revision(assimp
  URL     "https://github.com/assimp/assimp/archive/refs/tags/v5.3.1.tar.gz"
  DOWNLOAD_NAME assimp-v5.3.1.tar.gz
  URL_MD5 835357be3c1e70120fe2d5a52542ce55)

superbuild_set_revision(draco
  URL     "https://github.com/google/draco/archive/refs/tags/1.5.6.tar.gz"
  DOWNLOAD_NAME draco-1.5.7.tar.gz
  URL_MD5 dbe3a9e286ee5b79016470349d78b2a3)

superbuild_set_revision(occt
  URL     "https://github.com/Open-Cascade-SAS/OCCT/archive/refs/tags/V7_8_1.tar.gz"
  DOWNLOAD_NAME occt-V7_8_1.tar.gz
  URL_MD5 a1ae2c20422dd7a4352758667f34851f)

superbuild_set_revision(openexr
  URL     "https://github.com/AcademySoftwareFoundation/openexr/archive/refs/tags/v3.2.1.tar.gz"
  DOWNLOAD_NAME openexr-v3.2.1.tar.gz
  URL_MD5 1d5bb07433ec641cf3bb1b519a27ea6f)

superbuild_set_revision(openusd
  URL     "https://github.com/PixarAnimationStudios/OpenUSD/archive/refs/tags/v23.05.zip"
  DOWNLOAD_NAME openusd-v23.05.tar.gz
  URL_MD5 7318076a73ee76ac4221c63f01b2906f)

superbuild_set_revision(openvdb
  URL "https://github.com/AcademySoftwareFoundation/openvdb/archive/refs/tags/v11.0.0.tar.gz"
  DOWNLOAD_NAME openvdb-v11.0.0.tar.gz
  URL_MD5 025f4fc4db58419341a4991f1a16174a)

superbuild_set_selectable_source(vtk
  SELECT 9.3.0 DEFAULT
    URL     "https://www.vtk.org/files/release/9.3/VTK-9.3.0.tar.gz"
    URL_MD5 8b4dbb0ec85a6c0cf39803b6f891a8f2
  SELECT git CUSTOMIZABLE
    GIT_REPOSITORY "https://gitlab.kitware.com/vtk/vtk.git"
    GIT_TAG        "origin/master"
  SELECT source CUSTOMIZABLE
    SOURCE_DIR "source-vtk")

superbuild_set_selectable_source(f3d
  SELECT 2.4.0
    URL     "https://github.com/f3d-app/f3d/archive/refs/tags/v2.4.0.tar.gz"
    DOWNLOAD_NAME f3d-v2.4.0.tar.gz
    URL_MD5 6db37733b7fb4db8d86566348cc6ca90
  SELECT git CUSTOMIZABLE DEFAULT
    GIT_REPOSITORY "https://github.com/f3d-app/f3d.git"
    GIT_TAG        "origin/master"
  SELECT source CUSTOMIZABLE
    SOURCE_DIR "source-f3d")
