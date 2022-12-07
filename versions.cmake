superbuild_set_revision(occt
  URL     "https://github.com/Open-Cascade-SAS/OCCT/archive/refs/tags/V7_6_3.tar.gz"
  DOWNLOAD_NAME occt-V7_6_3.tar.gz
  URL_MD5 00f8dc72a7cf378598f52e2216a15ea4)

superbuild_set_revision(assimp
  URL     "https://github.com/assimp/assimp/archive/refs/tags/v5.2.5.tar.gz"
  DOWNLOAD_NAME assimp-v5.2.5.tar.gz
  URL_MD5 0b5a5a2714f1126b9931cdb95f512c91)

superbuild_set_revision(imath
  URL     "https://github.com/AcademySoftwareFoundation/Imath/archive/refs/tags/v3.1.5.tar.gz"
  DOWNLOAD_NAME Imath-v3.1.5.tar.gz
  URL_MD5 dd375574276c54872b7b3d54053baff0)

superbuild_set_revision(alembic
  URL     "https://github.com/alembic/alembic/archive/refs/tags/1.8.3.tar.gz"
  DOWNLOAD_NAME alembic-1.8.3.tar.gz
  URL_MD5 2cd8d6e5a3ac4a014e24a4b04f4fadf9)

superbuild_set_selectable_source(vtk
  SELECT 9.2.2
    URL     "https://www.vtk.org/files/release/9.2/VTK-9.2.2.tar.gz"
    URL_MD5 35e80f6bb8805d1a5f995b4ee0f93718
  SELECT commit DEFAULT
    GIT_REPOSITORY "https://gitlab.kitware.com/vtk/vtk.git"
    GIT_TAG        "ea2b6b5ad1516f65684eff0972a198af873ca1c1"
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
