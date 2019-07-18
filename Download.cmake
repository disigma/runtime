cmake_minimum_required(VERSION 3.0)

message(STATUS "Downloading: ${URL}")

file(MAKE_DIRECTORY "${CACHE}")

file(DOWNLOAD "${URL}" "${CACHE}/${TARGET}.tar.gz" SHOW_PROGRESS STATUS status)

list(GET status 0 error)
list(GET status 1 message)
if(error)
    message(FATAL_ERROR "Failed to download, error=${error} message=${message}")
endif()

message(STATUS "Extracting ${CACHE}/${TARGET}.tar.gz")
execute_process(
    COMMAND ${CMAKE_COMMAND} -E tar Jxf "${CACHE}/${TARGET}.tar.gz"
    WORKING_DIRECTORY "${CACHE}"
    RESULT_VARIABLE error
)
if(error)
    message(FATAL_ERROR "Failed to extract ${CACHE}/${TARGET}.tar.gz")
endif()

set(OUTPUT "${INSTALL}/share/${TARGET}/${VERSION}")
file(MAKE_DIRECTORY "${OUTPUT}")

string(REGEX MATCHALL "[^:]+" FILES ${FILES})
foreach(FILE ${FILES})
    list(APPEND SEARCH ${CACHE}/${FILE})
endforeach(FILE)
file(GLOB binaries ${SEARCH})


file(MAKE_DIRECTORY "${INSTALL}/bin")
foreach(binary ${binaries})
    get_filename_component(name ${binary} NAME)
    file(COPY ${binary} DESTINATION ${OUTPUT})
    message(STATUS "Found ${binary}")
    message(STATUS "Linking ${INSTALL}/bin/${name} -> ${OUTPUT}/${name}")
    execute_process(
        COMMAND ${CMAKE_COMMAND} -E create_symlink ../share/${TARGET}/${VERSION}/${name} ${INSTALL}/bin/${name}
        WORKING_DIRECTORY "${INSTALL}/bin"
        RESULT_VARIABLE error
    )
    if(error)
        message(FATAL_ERROR "Failed to create symlink ${INSTALL}/bin/${name} -> ${OUTPUT}/${name}")
    endif()
endforeach(binary)
