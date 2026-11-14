superbuild_set_revision(alembic
  # https://github.com/alembic/alembic/releases
  URL     "https://github.com/alembic/alembic/archive/refs/tags/1.8.12.tar.gz"
  DOWNLOAD_NAME alembic-1.8.12.tar.gz
  URL_MD5 1f0f4e9fcd92f104dcdf825c6a08773f)

superbuild_set_revision(assimp
  URL     "https://github.com/assimp/assimp/archive/refs/tags/v6.0.6.tar.gz"
  DOWNLOAD_NAME assimp-v6.0.6.tar.gz
  URL_MD5 d51dd2934b02a09e43a0c2d903774b42)

superbuild_set_revision(draco
  URL     "https://github.com/google/draco/archive/refs/tags/1.5.9.tar.gz"
  DOWNLOAD_NAME draco-1.5.9.tar.gz
  URL_MD5 cd4c85e9acd5b445f0e0cca40ebd1658)

# Force embree to 4.2.0 because of
# https://github.com/f3d-app/f3d-superbuild/issues/260
superbuild_set_revision(embree
    URL     "https://www.paraview.org/files/dependencies/embree-4.2.0.tar.gz"
    URL_MD5 9e6abbfb230a2ea07e80fa193ed94186)

superbuild_set_revision(ffmpeg
    URL     "https://github.com/FFmpeg/FFmpeg/archive/refs/tags/n9.0.2.tar.gz"
    DOWNLOAD_NAME ffmpeg-n9.0.2.tar.gz
    URL_MD5 d1b1427d7e28c5c10e03b00c65180aa4)

superbuild_set_revision(imgui
  URL "https://github.com/ocornut/imgui/archive/refs/tags/v1.93.0.tar.gz"
  DOWNLOAD_NAME imgui-v1.93.0.tar.gz
  URL_MD5 76c8b7d8453d8b5845fd8b8b06aa1b87)

superbuild_set_revision(occt
  URL     "https://github.com/Open-Cascade-SAS/OCCT/archive/refs/tags/V8.0.1.tar.gz"
  DOWNLOAD_NAME occt-V8.0.1.tar.gz
  URL_MD5 5a4329b73b5814925bc827c14cc379a1)

superbuild_set_revision(openexr
  URL     "https://github.com/AcademySoftwareFoundation/openexr/archive/refs/tags/v3.5.4.tar.gz"
  DOWNLOAD_NAME openexr-v3.5.4.tar.gz
  URL_MD5 e595b30909f8cee0791ede0cd269ca08)

superbuild_set_revision(openjph
  URL     "https://github.com/aous72/OpenJPH/archive/refs/tags/0.33.0.tar.gz"
  DOWNLOAD_NAME openjph-0.33.0.tar.gz
  URL_MD5 ff4b1fd07374ba4ac3cfd4915661827a)

superbuild_set_revision(openh264
  URL     "https://github.com/cisco/openh264/archive/refs/tags/v2.7.0.tar.gz"
  DOWNLOAD_NAME openh264-v2.7.0.tar.gz
  URL_MD5 1514a475e1843b10d24f74b02ad4eaed)

superbuild_set_revision(openusd
  URL     "https://github.com/PixarAnimationStudios/OpenUSD/archive/refs/tags/v26.11.1.tar.gz"
  DOWNLOAD_NAME openusd-v26.11.1.tar.gz
  URL_MD5 c7b8e64f81d8569f9220e2f9c8a57317)

superbuild_set_revision(openvdb
  URL "https://github.com/AcademySoftwareFoundation/openvdb/archive/refs/tags/v14.0.0.tar.gz"
  DOWNLOAD_NAME openvdb-v14.0.0.tar.gz
  URL_MD5 862a1073d55caa785baa35c19e8b3417)

# pybind11 cannot be updated in common-superbuild for now
# https://gitlab.kitware.com/paraview/common-superbuild/-/work_items/87
superbuild_set_revision(pybind11
  URL     "https://github.com/pybind/pybind11/archive/refs/tags/v3.0.4.tar.gz"
  DOWNLOAD_NAME pybind11-3.0.4.tar.gz
  URL_MD5 933fa1b6b1fe34c9945ecb3fe67f5c4b)

superbuild_set_revision(webp
  URL     "https://github.com/webmproject/libwebp/archive/refs/tags/v1.6.0.tar.gz"
  DOWNLOAD_NAME webp-v1.6.0.tar.gz
  URL_MD5 d498caf9323a24ce3ed40b84c22a32cd)

superbuild_set_revision(webifc
  URL     "https://github.com/ThatOpen/engine_web-ifc/archive/refs/tags/0.79.tar.gz"
  DOWNLOAD_NAME webifc-0.79.tar.gz
  URL_MD5 e5bd8e5aaeda764a02a4d3ad392967b2)

superbuild_set_selectable_source(vtk
  SELECT 9.7.2 DEFAULT
    URL     "https://www.vtk.org/files/release/9.7/VTK-9.7.2.tar.gz"
    URL_MD5 6b177350e2ec5f9e348eef3766161a0a
  SELECT git CUSTOMIZABLE
    GIT_REPOSITORY "https://gitlab.kitware.com/vtk/vtk.git"
    GIT_TAG        "origin/master"
  SELECT source CUSTOMIZABLE
    SOURCE_DIR "source-vtk")

superbuild_set_selectable_source(f3d
  SELECT 4.0.1
    URL     "https://github.com/f3d-app/f3d/archive/refs/tags/v4.0.1.tar.gz"
    DOWNLOAD_NAME f3d-v4.0.1.tar.gz
    URL_MD5 4e7e3b385af31c9421dcc7e1ee1c0ad5
  SELECT git CUSTOMIZABLE DEFAULT
    GIT_REPOSITORY "https://github.com/f3d-app/f3d.git"
    GIT_TAG        "origin/master"
  SELECT source CUSTOMIZABLE
    SOURCE_DIR "source-f3d")
