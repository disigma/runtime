cmake_minimum_required(VERSION 3.0)

include(../../cmake/Me.cmake)

me_project(cpulimit-0.2 3RD INSTALL)

me_cmake(SOURCE_DIR "${CMAKE_CURRENT_SOURCE_DIR}/cmake")
me_make()
