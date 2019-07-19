cmake_minimum_required(VERSION 3.0)

set(ME_DOWNLOAD_CMAKE "${CMAKE_CURRENT_LIST_FILE}" CACHE PATH ME_DOWNLOAD_CMAKE)

function(me_download url)
    unset(binaries)
    foreach(binary ${ARGN})
        set(binaries "${binaries}:${binary}")
    endforeach()
    add_custom_command(
        OUTPUT make
        COMMAND ${CMAKE_COMMAND}
        "-DCACHE=${ME_BUILD_DIR}"
        "-DINSTALL=${ME_INSTALL_PREFIX}"
        "-DTARGET=${ME_PROJECT_NAME}"
        "-DVERSION=${ME_PROJECT_VERSION}"
        "-DURL=${url}"
        "-DBINARIES=${binaries}"
        -P "${ME_DOWNLOAD_CMAKE}"
        USES_TERMINAL
    )
endfunction(me_download)

if(NOT CMAKE_SCRIPT_MODE_FILE STREQUAL CMAKE_CURRENT_LIST_FILE)
    return()
endif()

if(x$ENV{EXT} STREQUAL x)
    message(STATUS "Skip external projects.")
    return()
endif()

if(NOT CACHE OR NOT URL OR NOT INSTALL)
    message(FATAL_ERROR "Missing required parameters(CACHE, URL, INSTALL)")
endif()

message(STATUS "Make directory ${CACHE}")
file(MAKE_DIRECTORY "${CACHE}")
set(DOWNLOAD_FILE "${CACHE}/${TARGET}.tar.gz")

if(NOT x$ENV{NO_DOWNLOAD} STREQUAL x)
    set(status 0 0)
elseif(x$ENV{NO_REWRITE} STREQUAL x OR NOT EXISTS ${DOWNLOAD_FILE})
    message(STATUS "Downloading: ${URL}")
    file(DOWNLOAD "${URL}" "${DOWNLOAD_FILE}" SHOW_PROGRESS STATUS status)
endif()

list(GET status 0 error)
list(GET status 1 message)
if(error)
    message(FATAL_ERROR "Failed to download, error=${error} message=${message}")
endif()

set(EXTRACT "${CACHE}/extract")
file(REMOVE_RECURSE "${EXTRACT}")
file(MAKE_DIRECTORY "${EXTRACT}")
message(STATUS "Recreat directory ${EXTRACT}")

message(STATUS "Extracting ${DOWNLOAD_FILE}")
execute_process(
    COMMAND ${CMAKE_COMMAND} -E tar Jxf "${DOWNLOAD_FILE}"
    WORKING_DIRECTORY "${EXTRACT}"
    RESULT_VARIABLE error
)
if(error)
    message(FATAL_ERROR "Failed to extract ${DOWNLOAD_FILE}")
endif()

file(GLOB folder "${EXTRACT}/*/")
list(LENGTH folder count)
if(NOT count EQUAL 1)
    message(FATAL_ERROR "Error, Found multiple folders: ${folder}")
endif()
message(STATUS "Found folder: ${folder}")

set(OUTPUT "${INSTALL}/share/${TARGET}/${VERSION}")
file(REMOVE_RECURSE "${OUTPUT}")
file(MAKE_DIRECTORY "${INSTALL}/share/${TARGET}")
file(RENAME "${folder}" "${OUTPUT}")
message(STATUS "Move ${folder} to ${OUTPUT}")

string(REGEX MATCHALL "[^:]+" FILES ":${BINARIES}:")
foreach(FILE ${FILES})
    list(APPEND SEARCH "${OUTPUT}/${FILE}")
endforeach(FILE)

message(STATUS "Create directory ${INSTALL}/bin")
file(MAKE_DIRECTORY "${INSTALL}/bin")

file(GLOB binaries RELATIVE ${OUTPUT} ${SEARCH})
foreach(binary ${binaries})
    get_filename_component(name ${binary} NAME)
    message(STATUS "Found ${OUTPUT}/${binary}")
    message(STATUS "Linking ${INSTALL}/bin/${name} -> ${OUTPUT}/${binary}")
    execute_process(
        COMMAND ${CMAKE_COMMAND} -E create_symlink "../share/${TARGET}/${VERSION}/${binary}" "${INSTALL}/bin/${name}"
        WORKING_DIRECTORY "${INSTALL}/bin"
        RESULT_VARIABLE error
    )
    if(error)
        message(FATAL_ERROR "Failed to create symlink ${INSTALL}/bin/${name} -> ${OUTPUT}/${binary}")
    endif()
endforeach(binary)
