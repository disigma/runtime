cmake_minimum_required(VERSION 3.0)

include(../../cmake/Me.cmake)

me_project(telegraf-1.11.2 3RD INSTALL)

add_custom_command(
    OUTPUT make
    COMMAND ${CMAKE_COMMAND}
    "-DCACHE=${ME_BUILD_DIR}"
    "-DINSTALL=${ME_INSTALL_PREFIX}"
    "-DURL=https://dl.influxdata.com/telegraf/releases/telegraf-1.11.2_linux_amd64.tar.gz"
    "-DVERSION=1.11.2"
    "-DTARGET=telegraf"
    "-DFILES=*/usr/bin/telegraf"
    -P "${CMAKE_CURRENT_LIST_DIR}/../../Download.cmake"
    USES_TERMINAL
)
