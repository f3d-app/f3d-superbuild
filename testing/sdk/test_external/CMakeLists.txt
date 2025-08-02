project(test_external)

cmake_minimum_required(VERSION 3.10)

find_package(f3d REQUIRED)
find_package(OpenGL COMPONENTS EGL REQUIRED)

add_executable(test_external main.cxx)
target_link_libraries(test_external f3d::libf3d OpenGL::EGL)
set_target_properties(test_external PROPERTIES CXX_STANDARD 17)
