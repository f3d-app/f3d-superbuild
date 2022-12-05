set(test_sdk_build_dir "${CMAKE_CURRENT_BINARY_DIR}/test-sdk/${test_sdk_name}_build/")
execute_process (
  COMMAND 
    ${CMAKE_COMMAND}
    -S ${test_sdk_dir}
    -B ${test_sdk_build_dir}
    -Df3d_DIR:PATH=${f3d_install_dir}/lib/cmake/f3d/
    -DCMAKE_BUILD_TYPE=${superbuild_build_type}
    -DCMAKE_CONFIGURATION_TYPES=${superbuild_build_type}
    -G${superbuild_generator}
  RESULT_VARIABLE ret)
if (NOT ret EQUAL 0)
  message(FATAL_ERROR "Could not configure sdk test ${test_sdk_name}")
endif ()

execute_process (
  COMMAND 
    ${CMAKE_COMMAND}
    --build
    ${test_sdk_build_dir}
  RESULT_VARIABLE ret)
if (NOT ret EQUAL 0)
  message(FATAL_ERROR "Could not build sdk test ${test_sdk_name}")
endif ()

execute_process (
  COMMAND 
    ${CMAKE_COMMAND} -E env PATH=${f3d_install_dir}/bin/
    ${test_sdk_build_dir}/${test_sdk_exe}
  RESULT_VARIABLE ret)
if (NOT ret EQUAL 0)
  message(FATAL_ERROR "sdk test run fail ${test_sdk_name}")
endif ()
