project(test_external)

cmake_minimum_required(VERSION 3.2)

find_package(f3d REQUIRED)

add_executable(test_external main.cxx)
target_link_libraries(test_external f3d::libf3d)
