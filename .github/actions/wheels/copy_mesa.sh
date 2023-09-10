#!/bin/bash

python_bin_dir=`python -c 'import sys;from os.path import dirname; print(dirname(sys.executable))'`
echo `pwd`
cp $1/mesa/x64/opengl32.dll $python_bin_dir
cp $1/mesa/x64/libglapi.dll $python_bin_dir
cp $1/mesa/x64/libgallium_wgl.dll $python_bin_dir
