cmake_minimum_required(VERSION 3.0)

include(../../cmake/Me.cmake)

me_project(logrotate-3.15.0 3RD DEPENDS popt-1.16)

me_autoconf()
me_configure(CCFLAGS -I${popt-1.16-PREFIX}/include -L${popt-1.16-PREFIX}/lib)
me_make()

install(
    DIRECTORY ${ME_INSTALL_PREFIX}/sbin/
    DESTINATION ${CMAKE_INSTALL_PREFIX}/bin
    USE_SOURCE_PERMISSIONS
    COMPONENT ${ME_PROJECT}
)
me_install_target(${ME_PROJECT})
