#!/bin/bash
cmake -S ./source -B ./fsbb           \
  -DBUILD_SHARED_LIBS=OFF             \
  -DCMAKE_BUILD_TYPE=Release          \
  -DCMAKE_OSX_DEPLOYMENT_TARGET=12.0  \
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
  -DENABLE_pybind11=ON                \
  -DENABLE_tbb=OFF                    \
  -DENABLE_vtk=ON                     \
  -DENABLE_webp=ON                    \
  -DUSE_SYSTEM_python3=ON             \
  -Dvtk_SOURCE_SELECTION=git          \
  -Dvtk_GIT_TAG=$1
cmake --build ./fsbb
