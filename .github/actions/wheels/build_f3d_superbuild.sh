#!/bin/bash
cmake -S ./source -B ./fsbb      \
  -DBUILD_SHARED_LIBS=OFF    \
  -DCMAKE_BUILD_TYPE=Release \
  -DENABLE_f3d=OFF           \
  -DENABLE_alembic=OFF        \
  -DENABLE_assimp=OFF         \
  -DENABLE_draco=OFF          \
  -DENABLE_occt=OFF           \
  -DENABLE_openexr=OFF        \
  -DENABLE_ospray=OFF        \
  -DENABLE_pybind11=ON       \
  -DENABLE_tbb=OFF            \
  -DENABLE_vtk=ON            \
  -DOCCT_ENABLE_COLORING=OFF  \
  -DUSE_SYSTEM_python3=ON    \
  -Dvtk_SOURCE_SELECTION=git \
  -Dvtk_GIT_TAG=$1
cmake --build ./fsbb
