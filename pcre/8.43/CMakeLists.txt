cmake_minimum_required(VERSION 3.0)

include(../../cmake/Me.cmake)

me_project(pcre-8.43 3RD DEPENDS zlib-1.2.11)

me_cmake(
    FLAGS
    -DPCRE_BUILD_PCRECPP=OFF
    -DPCRE_BUILD_PCREGREP=OFF
    -DPCRE_BUILD_TESTS=OFF
    -DZLIB_ROOT=${zlib-1.2.11-PREFIX}
    -DZLIB_INCLUDE_DIR=${zlib-1.2.11-PREFIX}/include
    -DZLIB_LIBRARIES=${zlib-1.2.11-PREFIX}/lib/libz.a
)
me_make()
