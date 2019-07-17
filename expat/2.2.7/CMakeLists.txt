cmake_minimum_required(VERSION 3.0)

include(../../cmake/Me.cmake)

me_project(expat-2.2.7 3RD)

me_cmake(
    FLAGS
    -DBUILD_tools=OFF
    -DBUILD_examples=OFF
    -DBUILD_tests=OFF
    -DBUILD_shared=OFF
    -DBUILD_doc=OFF
    -DUSE_libbsd=OFF
)
me_make()
