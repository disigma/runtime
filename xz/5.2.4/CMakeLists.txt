cmake_minimum_required(VERSION 3.0)

include(../../cmake/Me.cmake)

me_project(xz-5.2.4 3RD LIBNAME lzma)

me_autoconf()
me_configure(
    FLAGS
    --disable-nls
    --disable-doc
    --without-libiconv-prefix
    --without-libintl-prefix
)
me_make()

install(
    DIRECTORY ${ME_INSTALL_PREFIX}/bin/
    DESTINATION ${CMAKE_INSTALL_PREFIX}/bin
    USE_SOURCE_PERMISSIONS
    COMPONENT ${ME_PROJECT}
)
me_install_target(${ME_PROJECT})

