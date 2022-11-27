project(test_rendering)

cmake_minimum_required(VERSION 3.2)

find_package(f3d REQUIRED)

add_executable(test_rendering main.cxx)
target_link_libraries(test_rendering f3d::libf3d)
