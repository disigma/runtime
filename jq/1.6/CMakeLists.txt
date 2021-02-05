cmake_minimum_required(VERSION 3.0)

include(../../cmake/Me.cmake)

me_project(jq-1.6 3RD INSTALL)

me_autoconf()
me_configure(FLAGS --with-oniguruma=builtin --disable-maintainer-mode)
me_make()
