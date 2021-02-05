cmake_minimum_required(VERSION 3.0)

include(../../cmake/Me.cmake)

me_project(patchelf-0.12 3RD INSTALL)

me_autoconf()
me_configure()
me_make()
