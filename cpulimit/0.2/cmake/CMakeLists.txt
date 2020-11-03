cmake_minimum_required(VERSION 3.0)

project(cpulimit)

add_definitions(-D_GNU_SOURCE)

set(
    sources
    ../sources/src/cpulimit.c
    ../sources/src/list.c
    ../sources/src/process_iterator.c
    ../sources/src/process_group.c
)

add_executable(cpulimit ${sources})

install(TARGETS cpulimit DESTINATION bin)
