#!/bin/bash
cmake -S ./source -B ./fsbb      \
  -DBUILD_SHARED_LIBS=OFF    \
  -DCMAKE_BUILD_TYPE=Release \
  -DENABLE_f3d=OFF           \
  -DENABLE_alembic=ON        \
  -DENABLE_assimp=ON         \
  -DENABLE_draco=ON          \
  -DENABLE_occt=ON           \
  -DENABLE_openexr=ON        \
  -DENABLE_ospray=OFF        \
  -DENABLE_pybind11=ON       \
  -DENABLE_tbb=ON            \
  -DENABLE_vtk=ON            \
  -DOCCT_ENABLE_COLORING=ON  \
  -Dvtk_SOURCE_SELECTION=git \
  -DCMAKE_CXX_FLAGS='-D_GLIBCXX_USE_CXX11_ABI=1' \
  -Dvtk_GIT_TAG=$1
cmake --build ./fsbb
