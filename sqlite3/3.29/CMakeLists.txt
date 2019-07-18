cmake_minimum_required(VERSION 3.0)

include(../../cmake/Me.cmake)

me_project(sqlite3-3.29 3RD)

me_autoconf()
me_configure()
me_make(TARGETS install-libLTLIBRARIES install-data)
