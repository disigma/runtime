cmake_minimum_required(VERSION 3.0)

include(../../cmake/Me.cmake)
include(../../MeDownload.cmake)

me_project(influxdb-1.7.7 3RD INSTALL)

me_download(
    "https://dl.influxdata.com/influxdb/releases/influxdb-1.7.7-static_linux_amd64.tar.gz"
    "influx"
    "influxd"
    "influx_inspect"
    "influx_stress"
    "influx_tsm"
)
