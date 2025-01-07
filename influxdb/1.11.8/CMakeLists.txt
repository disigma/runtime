cmake_minimum_required(VERSION 3.0)

include(../../cmake/Me.cmake)
include(../../MeDownload.cmake)

me_project(influxdb-1.11.8 3RD INSTALL)

me_download(
    "https://download.influxdata.com/influxdb/releases/influxdb-1.11.8-linux-amd64.tar.gz"
    "influx"
    "influxd"
    "influx_inspect"
    "influx_stress"
    "influx_tsm"
)
