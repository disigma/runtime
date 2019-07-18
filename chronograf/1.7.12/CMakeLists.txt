cmake_minimum_required(VERSION 3.0)

include(../../cmake/Me.cmake)

me_project(chronograf-1.7.12 3RD INSTALL)

add_custom_command(
    OUTPUT make
    COMMAND ${CMAKE_COMMAND}
    "-DCACHE=${ME_BUILD_DIR}"
    "-DINSTALL=${ME_INSTALL_PREFIX}"
    "-DURL=https://dl.influxdata.com/chronograf/releases/chronograf-1.7.12_linux_amd64.tar.gz"
    "-DVERSION=1.7.12"
    "-DTARGET=chronograf"
    "-DFILES=usr/bin/chronoctl:usr/bin/chronograf"
    -P "${CMAKE_CURRENT_LIST_DIR}/../../Download.cmake"
    USES_TERMINAL
)
