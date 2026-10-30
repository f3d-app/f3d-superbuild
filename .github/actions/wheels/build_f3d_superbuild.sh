#!/bin/bash
# tiff is build shared because of https://gitlab.kitware.com/paraview/common-superbuild/-/work_items/90
# hdf5 is build shared because of https://gitlab.kitware.com/paraview/common-superbuild/-/work_items/86
# openh264 is build shared because of https://github.com/f3d-app/f3d-superbuild/issues/370
# ffmpeg is build shared because it's LGPL
# openssl is enabled because python < 3.15 is not compatible with OpenSSL 4.0+ system version: https://gitlab.kitware.com/paraview/common-superbuild/-/work_items/95
cmake -S ./source -B ./fsbb           \
  -D_superbuild_enable_openssl=ON     \
  -DBUILD_SHARED_LIBS=OFF             \
  -DBUILD_SHARED_LIBS_ffmpeg=ON       \
  -DBUILD_SHARED_LIBS_hdf5=ON         \
  -DBUILD_SHARED_LIBS_netcdf=ON       \
  -DBUILD_SHARED_LIBS_openh264=ON     \
  -DBUILD_SHARED_LIBS_tiff=ON         \
  -DCMAKE_BUILD_TYPE=Release          \
  -DCMAKE_OSX_DEPLOYMENT_TARGET=14.0  \
  -DENABLE_alembic=OFF                 \
  -DENABLE_assimp=OFF                  \
  -DENABLE_draco=OFF                   \
  -DENABLE_egl=OFF                     \
  -DENABLE_f3d=OFF                    \
  -DENABLE_ffmpeg=OFF                  \
  -DENABLE_imgui=OFF                   \
  -DENABLE_occt=OFF                    \
  -DENABLE_openexr=OFF                 \
  -DENABLE_openssl=ON                 \
  -DENABLE_openusd=OFF                \
  -DENABLE_openvdb=ON                 \
  -DENABLE_osmesa=OFF                  \
  -DENABLE_ospray=OFF                 \
  -DENABLE_pdal=OFF                    \
  -DENABLE_pybind11=ON                \
  -DENABLE_tbb=OFF                    \
  -DENABLE_vtk=ON                     \
  -DENABLE_webifc=OFF                  \
  -DENABLE_webp=OFF                    \
  -Dmesa_SOURCE_SELECTION=25.0.7      \
  -Dvtk_SOURCE_SELECTION=git          \
  -Dvtk_GIT_TAG=$1

cmake --build ./fsbb
