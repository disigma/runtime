cmake_minimum_required(VERSION 3.0)

include(../../cmake/Me.cmake)
include(../../MeDownload.cmake)

me_project(etcd-3.3.18 3RD INSTALL)

me_download(
    "https://github.com/etcd-io/etcd/releases/download/v3.3.18/etcd-v3.3.18-linux-amd64.tar.gz"
    "etcd"
    "etcdctl"
)
