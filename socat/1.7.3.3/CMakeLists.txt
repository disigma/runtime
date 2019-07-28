cmake_minimum_required(VERSION 3.0)

include(../../cmake/Me.cmake)

me_project(
    socat-1.7.3.3 3RD INSTALL DEPENDS
    libressl-2.9.2--ssl
    readline-8.0
)

me_configure()
me_make()
