#!/bin/bash

set -e -u

cmake -S f3d-superbuild -B f3d-superbuild-build \
        -DBUILD_SHARED_LIBS=OFF \
        -DCMAKE_BUILD_TYPE=Release \
        -DENABLE_f3d=OFF \
        -DENABLE_alembic=ON \
        -DENABLE_assimp=ON \
        -DENABLE_draco=ON \
        -DENABLE_occt=ON \
        -DENABLE_openexr=ON \
        -DENABLE_ospray=OFF \
        -DENABLE_pybind11=ON \
        -DENABLE_tbb=ON \
        -DENABLE_vtk=ON \
        -DOCCT_ENABLE_COLORING=ON \
        -Dvtk_SOURCE_SELECTION=git \
        -Dvtk_GIT_TAG=$1

cmake --build f3d-superbuild-build
