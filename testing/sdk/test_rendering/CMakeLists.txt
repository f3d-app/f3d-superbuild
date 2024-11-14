project(test_rendering)

cmake_minimum_required(VERSION 3.10)

find_package(f3d REQUIRED)

add_executable(test_rendering main.cxx)
target_link_libraries(test_rendering f3d::libf3d)
set_target_properties(test_rendering PROPERTIES CXX_STANDARD 17)
