cmake_minimum_required(VERSION 3.0)

include(../../cmake/Me.cmake)

me_project(zlib-1.2.11 3RD LIBNAME z)

me_cmake(SOURCE_DIR "${CMAKE_CURRENT_SOURCE_DIR}/cmake")
me_make()
