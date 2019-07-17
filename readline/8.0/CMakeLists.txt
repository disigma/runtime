cmake_minimum_required(VERSION 3.0)

include(../../cmake/Me.cmake)

me_project(readline-8.0 3RD DEPENDS ncurses-6.1)

me_configure(FLAGS --disable-install-examples --with-curses)
me_make()
