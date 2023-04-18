superbuild_set_revision(alembic
  URL     "https://github.com/alembic/alembic/archive/refs/tags/1.8.5.tar.gz"
  DOWNLOAD_NAME alembic-1.8.5.tar.gz
  URL_MD5 fcd5b5492a005057e11b601b60ac9a49)

superbuild_set_revision(assimp
  URL     "https://github.com/assimp/assimp/archive/refs/tags/v5.2.5.tar.gz"
  DOWNLOAD_NAME assimp-v5.2.5.tar.gz
  URL_MD5 0b5a5a2714f1126b9931cdb95f512c91)

superbuild_set_revision(draco
  URL     "https://github.com/google/draco/archive/refs/tags/1.5.6.tar.gz"
  DOWNLOAD_NAME draco-1.5.6.tar.gz
  URL_MD5 dbe3a9e286ee5b79016470349d78b2a3)

superbuild_set_revision(imath
  URL     "https://github.com/AcademySoftwareFoundation/Imath/archive/refs/tags/v3.1.7.tar.gz"
  DOWNLOAD_NAME Imath-v3.1.7.tar.gz
  URL_MD5 5cedab446ab296c080957c3037c6d097)

superbuild_set_revision(occt
  URL     "https://github.com/Open-Cascade-SAS/OCCT/archive/refs/tags/V7_6_3.tar.gz"
  DOWNLOAD_NAME occt-V7_6_3.tar.gz
  URL_MD5 00f8dc72a7cf378598f52e2216a15ea4)

superbuild_set_selectable_source(vtk
  SELECT 9.2.6 DEFAULT
    URL     "https://www.vtk.org/files/release/9.2/VTK-9.2.6.tar.gz"
    URL_MD5 d855cbabdf423f2839e1419ecc5f6700
  SELECT git CUSTOMIZABLE
    GIT_REPOSITORY "https://gitlab.kitware.com/vtk/vtk.git"
    GIT_TAG        "origin/master"
  SELECT source CUSTOMIZABLE
    SOURCE_DIR "source-vtk")

superbuild_set_selectable_source(f3d
  SELECT 1.3.1
    URL     "https://github.com/f3d-app/f3d/archive/refs/tags/v1.3.1.tar.gz"
    DOWNLOAD_NAME f3d-v1.3.1.tar.gz
    URL_MD5 37d126e84853cb6dfc030efdd5b6bf05
  SELECT git CUSTOMIZABLE DEFAULT
    GIT_REPOSITORY "https://github.com/f3d-app/f3d.git"
    GIT_TAG        "origin/master"
  SELECT source CUSTOMIZABLE
    SOURCE_DIR "source-f3d")
