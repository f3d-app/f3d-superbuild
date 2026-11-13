# Recover all files
file(GLOB_RECURSE _files RELATIVE "${CMAKE_ARGV3}" ./*.*)

# remove .. files
list(FILTER _files EXCLUDE REGEX "\\.\\.")

# Check each files contains the needed string
foreach(_file ${_files})
  message(WARNING ${_file})
  if (NOT "${_file}" MATCHES ".*${CMAKE_ARGV4}.*")
    message(FATAL_ERROR "${_file} does not contain expected ${CMAKE_ARGV4}")
  endif()
endforeach()
