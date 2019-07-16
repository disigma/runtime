cmake_minimum_required(VERSION 3.0)

include(../../cmake/Me.cmake)

me_project(byobu-5.129 3RD INSTALL)

me_autoconf()
me_configure()
me_make()
