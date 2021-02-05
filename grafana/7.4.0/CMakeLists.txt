cmake_minimum_required(VERSION 3.0)

include(../../cmake/Me.cmake)
include(../../MeDownload.cmake)

me_project(grafana-7.4.0 3RD INSTALL)

me_download(
    "https://dl.grafana.com/oss/release/grafana-7.4.0.linux-amd64.tar.gz"
    "bin/grafana-cli"
    "bin/grafana-server"
)
