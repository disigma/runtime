cmake_minimum_required(VERSION 3.0)

include(../../cmake/Me.cmake)

me_project(libressl-2.9.2 3RD META)
me_project(libressl-2.9.2--crypto 3RD ALIAS LIBS dl)
me_project(libressl-2.9.2--ssl 3RD ALIAS DEPENDS libressl-2.9.2--crypto)

me_cmake(
    FLAGS
    -DLIBRESSL_APPS=OFF
    -DLIBRESSL_TESTS=OFF
    -DENABLE_EXTRATESTS=OFF
    -DBUILD_SHARED_LIBS=OFF
)
me_make()
