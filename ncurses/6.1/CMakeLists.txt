cmake_minimum_required(VERSION 3.0)

include(../../cmake/Me.cmake)

me_project(ncurses-6.1 3RD)

me_configure(
    FLAGS
    --without-ada
    --without-cxx
    --without-cxx-binding
    --disable-db-install
    --without-manpages
    --without-progs
    --without-tack
    --without-tests
    --enable-pc-files
    --without-debug
    --disable-lib-suffixes
)
me_make()
