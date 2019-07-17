cmake_minimum_required(VERSION 3.0)

include(../../cmake/Me.cmake)

me_project(elfutils-0.176 3RD LIBNAME elf DEPENDS zlib-1.2.11)

me_cmake(
    SOURCE_DIR ${CMAKE_CURRENT_LIST_DIR}/cmake
    FLAGS -DZLIB_ROOT=${zlib-1.2.11-PREFIX}
)
me_make()
