cmake_minimum_required(VERSION 3.0)

include(../../cmake/Me.cmake)
include(../../MeDownload.cmake)

me_project(kapacitor-1.5.3 3RD INSTALL)

me_download(
    "https://dl.influxdata.com/kapacitor/releases/kapacitor-1.5.3_linux_amd64.tar.gz"
    "usr/bin/kapacitor"
    "usr/bin/kapacitord"
    "usr/bin/tickfmt"
)
