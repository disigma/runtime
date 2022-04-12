cmake_minimum_required(VERSION 3.0)

include(../../cmake/Me.cmake)
include(../../MeDownload.cmake)

me_project(grafana-8.4.5 3RD INSTALL)

me_download(
    "https://dl.grafana.com/oss/release/grafana-8.4.5.linux-amd64.tar.gz"
    "bin/grafana-cli"
    "bin/grafana-server"
)
