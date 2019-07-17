cmake_minimum_required(VERSION 3.0)

include(FindPkgConfig)

pkg_check_modules(ZLIB REQUIRED zlib)

include_directories(
    ${ZLIB_INCLUDE_DIRS}
    ../sources/libelf
    ../sources/lib
)

add_compile_options(-include eu-config.h)

aux_source_directory(../sources/libelf sources)
set(
    headers
    ../sources/libelf/elf.h
    ../sources/libelf/libelf.h
    ../sources/libelf/gelf.h
)

add_library(elf ${sources})

install(TARGETS elf DESTINATION lib)
install(FILES ${headers} DESTINATION include)
