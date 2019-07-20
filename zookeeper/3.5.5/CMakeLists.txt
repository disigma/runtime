cmake_minimum_required(VERSION 3.0)

include(../../cmake/Me.cmake)
include(../../MeDownload.cmake)

me_project(zookeeper-3.5.5 3RD INSTALL)

me_download(
    "https://archive.apache.org/dist/zookeeper/zookeeper-3.5.5/apache-zookeeper-3.5.5-bin.tar.gz"
)

configure_file(cmake/zkserver ${ME_BUILD_DIR}/zkserver @ONLY)
configure_file(cmake/zkcli ${ME_BUILD_DIR}/zkcli @ONLY)
install(
    FILES
    "${ME_BUILD_DIR}/zkserver"
    "${ME_BUILD_DIR}/zkcli"
    DESTINATION bin
    PERMISSIONS
    OWNER_WRITE
    OWNER_READ GROUP_READ WORLD_READ
    OWNER_EXECUTE GROUP_EXECUTE WORLD_EXECUTE
    COMPONENT ${ME_PROJECT}
)
