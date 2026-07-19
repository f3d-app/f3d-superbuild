#!/bin/bash
# tiff is build shared because of https://gitlab.kitware.com/paraview/common-superbuild/-/work_items/90
# hdf5 is build shared because of https://gitlab.kitware.com/paraview/common-superbuild/-/work_items/86
cmake -S ./source -B ./fsbb           \
  -DBUILD_SHARED_LIBS=OFF             \
  -DBUILD_SHARED_LIBS_hdf5=ON         \
  -DBUILD_SHARED_LIBS_netcdf=ON       \
  -DBUILD_SHARED_LIBS_tiff=ON         \
  -DCMAKE_BUILD_TYPE=Release          \
  -DCMAKE_OSX_DEPLOYMENT_TARGET=14.0  \
  -DENABLE_f3d=OFF                    \
  -DENABLE_alembic=ON                 \
  -DENABLE_assimp=ON                  \
  -DENABLE_draco=ON                   \
  -DENABLE_egl=ON                     \
  -DENABLE_imgui=ON                   \
  -DENABLE_occt=ON                    \
  -DENABLE_openexr=ON                 \
  -DENABLE_openusd=OFF                \
  -DENABLE_openvdb=OFF                \
  -DENABLE_osmesa=ON                  \
  -DENABLE_ospray=OFF                 \
  -DENABLE_pdal=ON                    \
  -DENABLE_pybind11=ON                \
  -DENABLE_tbb=OFF                    \
  -DENABLE_vtk=ON                     \
  -DENABLE_webifc=ON                  \
  -DENABLE_webp=ON                    \
  -Dvtk_SOURCE_SELECTION=git          \
  -Dvtk_GIT_TAG=$1
cmake --build ./fsbb
