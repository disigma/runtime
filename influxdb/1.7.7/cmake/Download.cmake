cmake_minimum_required(VERSION 3.0)

message(STATUS "Downloading: ${URL}")

file(MAKE_DIRECTORY "${CACHE}")

file(DOWNLOAD "${URL}" "${CACHE}/influxdb.tar.gz" SHOW_PROGRESS STATUS status)

list(GET status 0 error)
list(GET status 1 message)
if(error)
    message(FATAL_ERROR "Failed to download, error=${error} message=${message}")
endif()

file(MAKE_DIRECTORY "${INSTALL}/share/influxdb")

message(STATUS "Extracting ${CACHE}/influxdb.tar.gz")
execute_process(
    COMMAND ${CMAKE_COMMAND} -E tar Jxf "${CACHE}/influxdb.tar.gz"
    WORKING_DIRECTORY "${INSTALL}/share/influxdb"
    RESULT_VARIABLE error
)
if(error)
    message(FATAL_ERROR "Failed to extract ${CACHE}/influxdb.tar.gz")
endif()

file(GLOB_RECURSE binaries RELATIVE ${INSTALL} influx influxd influx_inspect influx_stress influx_tsm)

file(MAKE_DIRECTORY "${INSTALL}/bin")
foreach(binary ${binaries})
    get_filename_component(name ${binary} NAME)
    message(STATUS "Linking ${INSTALL}/bin/${name} -> ${INSTALL}/${binary}")
    execute_process(
        COMMAND ${CMAKE_COMMAND} -E create_symlink ../${binary} ${INSTALL}/bin/${name}
        WORKING_DIRECTORY "${INSTALL}/bin"
        RESULT_VARIABLE error
    )
    if(error)
        message(FATAL_ERROR "Failed to create symlink ${INSTALL}/bin/${name} -> ${INSTALL}/${binary}")
    endif()
endforeach(binary)
