cmake_minimum_required(VERSION 3.0)

include(cmake/MeRoot.cmake)
include(cmake/Me.cmake)

me_import(
    flvmeta-1.2.1
    ffmpeg-release
    socat-1.7.3.3
    logrotate-3.15.0
    zookeeper-3.5.5
    grafana-7.4.0
    telegraf-1.11.2
    chronograf-1.7.12
    kapacitor-1.5.3
    influxdb-1.7.7
    fluent-bit-1.2.1
    byobu-5.129
    nginx-1.17.1
    ltrace-0.7.3
    python-3.7.4
    xz-5.2.4
    uwsgi-2.0.18
    etcd-3.3.18
    cpulimit-0.2
    valgrind-3.16.1
    jq-1.6
)

me_import(${ME_EXTRA_PROJECTS})

if(CMAKE_SCRIPT_MODE_FILE)
    set(ENV{DIST} 1)
    set(ENV{NO_DBG} 1)
    include(MeMakefile)
    me_makefile_make(strip-all)
    return()
endif()

include(cmake/MeStripAll.cmake)
