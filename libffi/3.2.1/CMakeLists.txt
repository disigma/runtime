cmake_minimum_required(VERSION 3.0)

include(../../cmake/Me.cmake)

me_project(libffi-3.2.1 3RD LIBNAME ffi)

me_autoconf()
me_configure()
me_make()
