cmake_minimum_required(VERSION 3.0)

include(../../cmake/Me.cmake)

me_project(kapacitor-1.5.3 3RD INSTALL)

add_custom_command(
    OUTPUT make
    COMMAND ${CMAKE_COMMAND}
    "-DCACHE=${ME_BUILD_DIR}"
    "-DINSTALL=${ME_INSTALL_PREFIX}"
    "-DURL=https://dl.influxdata.com/kapacitor/releases/kapacitor-1.5.3_linux_amd64.tar.gz"
    "-DVERSION=1.5.3"
    "-DTARGET=kapacitor"
    "-DFILES=usr/bin/kapacitor:usr/bin/kapacitord:usr/bin/tickfmt"
    -P "${CMAKE_CURRENT_LIST_DIR}/../../Download.cmake"
    USES_TERMINAL
)
