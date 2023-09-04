#!/bin/bash

set -e -u

sccache --start-server

cmake -S f3d-superbuild -B f3d-superbuild-build \
        -DCMAKE_CXX_COMPILER_LAUNCHER=sccache \
        -DCMAKE_C_COMPILER_LAUNCHER=sccache \
        -DBUILD_SHARED_LIBS=OFF \
        -DCMAKE_BUILD_TYPE=Release \
        -DENABLE_f3d=OFF \
        -DENABLE_alembic=ON \
        -DENABLE_assimp=ON \
        -DENABLE_draco=ON \
        -DENABLE_occt=OFF \
        -DENABLE_openexr=ON \
        -DENABLE_ospray=OFF \
        -DENABLE_pybind11=OFF \
        -DENABLE_tbb=OFF \
        -DENABLE_vtk=OFF \
        -DOCCT_ENABLE_COLORING=OFF \
        -Dvtk_SOURCE_SELECTION=git \
        -Dvtk_GIT_TAG=$1


cmake --build f3d-superbuild-build

sccache --stop-server
