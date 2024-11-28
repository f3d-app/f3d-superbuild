# F3D Superbuild

F3D Superbuild is the project responsible for the creation of the binary package of F3D, available on
[f3d.app](https://f3d.app/doc/user/INSTALLATION.html). It can also be usefull to build F3D and all its dependencies
in a more automated way.

It relies on the [common-superbuild](https://gitlab.kitware.com/paraview/common-superbuild/) logic and contains
it as a git submodule.

The idea of a superbuild is to download, configure, build, install and package every single dependency of a program,
and the program itself of course, and this is what F3D Superbuild is doing for F3D.

This repository also generate a nightly release of F3D.

# How to use locally to generate a package of F3D master branch

 - Clone the F3D superbuild main branch
 - Create a build directory
 - Run `cmake` from the build directory pointing to F3D superbuild source, multi-config generator are not supported
 - Change options as needed, defaults options are correct to generate a package of F3D master branch
 - Build the whole project, this will take a while, the result is stored in the `install` directory
 - Run `cmake` again to update the `f3d-version.cmake` file used by the packaging step
 - Run `ctest` to run create the package and test it
 - Relocatable binary package have been generated in the build directory

# How to use locally to generate a package of a specific F3D release

 - Clone the F3D superbuild main branch
 - Checkout the tag of the needed release (`vN.M.O`, earlier supported is `v1.3.1`).
 - Create a build directory
 - Run `cmake` from the build directory pointing to F3D superbuild source, multi-config generator are not supported
 - Change options as needed, defaults options are correct to generate a package of F3D master branch
 - Build the whole project, this will take a while, the result is stored in the `install` directory
 - Run `cmake` again to update the `f3d-version.cmake` file used by the packaging step
 - Run `ctest` to run create the package and test it
 - Relocatable binary package have been generated in the build directory

# How to use on github to generate a package of F3D master branch

 - Navigate to https://github.com/f3d-app/f3d-superbuild/actions/workflows/release.yml
 - Click "run workflow", with branch: main, F3D version to build: origin/master, Superbuild branch/tag to use: main
 - Wait for github actions to finish, this will take a while
 - Download the relocatable package which are available as artifacts

# How to use on github to generate a package of a specific F3D tag, like a RC

 - Assuming the wanted tag exists on f3d-app/f3d and is named $tag.
 - Navigate to https://github.com/f3d-app/f3d-superbuild/actions/workflows/release.yml
 - Click "run workflow", with branch: main, "F3D version to build": $tag, "Superbuild branch/tag to use": main
 - Set "Publish assets" to true to publish the resulting assets to an existing F3D prerelease.
 - Wait for github actions to finish, this will take a while
 - Download the relocatable package which are available as artifacts

# How to use on github to generate a package of a specific F3D release

 - Assuming the wanted release is vN.M.O
 - Navigate to https://github.com/f3d-app/f3d-superbuild/actions/workflows/release.yml
 - Click "run workflow", with branch: vN.M.O, F3D version to build: vN.M.O, Superbuild branch/tag to use: vN.M.O
 - Wait for github actions to finish, this will take a while
 - Download the relocatable package which are available as artifacts

# CMake Options

 - `ENABLE_f3d`: ON by default, obviously required to packaged F3D
 - `ENABLE_alembic`: ON by defaut, build and package alembic and the associated F3D plugin
 - `ENABLE_assimp`: ON by defaut, build and package assimp and the associated F3D plugin
 - `ENABLE_draco`: ON by defaut, build and package draco and the associated F3D plugin
 - `ENABLE_imgui`: ON by default, build and package imgui and the associated F3D module
 - `ENABLE_occt`: ON by defaut, build and package occt and the associated F3D plugin
 - `ENABLE_openexr`: ON by default, build and package OpenEXR and the associated F3D module
 - `ENABLE_ospray`: ON by defaut, build and package ospray and the associated VTK module
 - `ENABLE_tbb`: ON by default, build and package TBB to enable multi-threading
 - `ENABLE_pybind11`: OFF by defaut, build pybind11 and F3D python bindings, not packageable
 - `USE_SYSTEM_python3`: OFF by default, can be enabled if available as python is only a build time dependency
 - `f3d_SOURCE_SELECTION`: git by default, let the user choose the version of F3D to build and package
 - `f3d_GIT_TAG`: master by default, when using `-Df3d_SOURCE_SELECTION=git`, select the branch or commit to build
 - `vtk_SOURCE_SELECTION`: 9.2.6 by default, select the version of VTK to build and package
 - `vtk_GIT_TAG`: master by default, when using `-Dvtk_SOURCE_SELECTION=git`, select the branch or commit to build
 - `BUILD_TESTING`: ON by default, required for the packaging step

# License
see the BSD 3-Clause [LICENSE](LICENSE).

# Acknowledgments
 - Inspired by/Copied from paraview-superbuild, Copyright (c) 2005-2008 Sandia Corporation, Kitware Inc.
 - Uses FileAssociation.nsh, Copyright (c) Vytautas Krivickas from https://nsis.sourceforge.io/File_Association.
