superbuild_add_project(draco
  LICENSE_FILES
    LICENSE
  CMAKE_ARGS
    -DDRACO_BACKWARDS_COMPATIBILITY=OFF
    -DDRACO_JS_GLUE=OFF
    -DDRACO_PREDICTIVE_EDGEBREAKER=OFF
    -DDRACO_STANDARD_EDGEBREAKER=OFF
    -DCMAKE_BUILD_TYPE=Release
    -DBUILD_SHARED_LIBS=ON
    -DCMAKE_MACOSX_RPATH=OFF
)

# https://github.com/google/draco/pull/951
# Remove when updating draco to the next release after 1.5.5
superbuild_apply_patch(draco fix-signed-unsigned-mismatch-warning-in-decoder_buff
  "Fix signed/unsigned mismatch in decoder_buffer.h")
