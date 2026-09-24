find_program(BASH_EXECUTABLE
  NAMES bash
  DOC "bash binary")
mark_as_advanced(BASH_EXECUTABLE)

if (NOT BASH_EXECUTABLE)
  message(FATAL_ERROR "Missing `bash` executable")
endif ()
