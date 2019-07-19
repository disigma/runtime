cmake_minimum_required(VERSION 3.0)

include(../../cmake/Me.cmake)
include(../../MeDownload.cmake)

me_project(telegraf-1.11.2 3RD INSTALL)

me_download(
    "https://dl.influxdata.com/telegraf/releases/telegraf-1.11.2_linux_amd64.tar.gz"
    "usr/bin/telegraf"
)
