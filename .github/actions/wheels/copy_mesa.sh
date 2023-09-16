#!/bin/bash

# Copy mesa to the right location, next to the future location of libf3d python module
python_bin_dir=`python -c 'import sys;from os.path import dirname; print(dirname(sys.executable))'`
#mkdir $python_bin_dir/../Lib/site-packages/f3d/
#cp $1/mesa/x64/opengl32.dll $python_bin_dir/../Lib/site-packages/f3d/
#cp $1/mesa/x64/libglapi.dll $python_bin_dir/../Lib/site-packages/f3d/
#cp $1/mesa/x64/libgallium_wgl.dll $python_bin_dir/../Lib/site-packages/f3d
echo $python_bin_dir
