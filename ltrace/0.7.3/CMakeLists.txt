cmake_minimum_required(VERSION 3.0)

include(../../cmake/Me.cmake)

me_project(ltrace-0.7.3 3RD INSTALL DEPENDS elfutils-0.176 zlib-1.2.11)

me_autoconf()
me_configure(
    FLAGS "--with-libelf=${elfutils-0.176-PREFIX}" "--disable-werror"
    ENV "LIBS=${zlib-1.2.11-LIBS}"
)
me_make()
