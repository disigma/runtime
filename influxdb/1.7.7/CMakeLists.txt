cmake_minimum_required(VERSION 3.0)

include(../../cmake/Me.cmake)

me_project(influxdb-1.7.7 3RD INSTALL)

add_custom_command(
    OUTPUT make
    COMMAND ${CMAKE_COMMAND}
    "-DCACHE=${ME_BUILD_DIR}"
    "-DINSTALL=${ME_INSTALL_PREFIX}"
    "-DURL=https://dl.influxdata.com/influxdb/releases/influxdb-1.7.7-static_linux_amd64.tar.gz"
    -P "${CMAKE_CURRENT_LIST_DIR}/cmake/Download.cmake"
    USES_TERMINAL
)
