cmake_minimum_required(VERSION 3.0)

include(../../cmake/Me.cmake)

me_project(bzip2-1.0.8 3RD LIBNAME bz2)

me_cmake(SOURCE_DIR "${CMAKE_CURRENT_SOURCE_DIR}/cmake")
me_make()
