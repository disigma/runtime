cmake_minimum_required(VERSION 3.0)

project(bzip2)

set(
    sources
    ../sources/blocksort.c
    ../sources/huffman.c
    ../sources/crctable.c
    ../sources/randtable.c
    ../sources/compress.c
    ../sources/decompress.c
    ../sources/bzlib.c
)

add_library(bz2 ${sources})

install(TARGETS bz2 DESTINATION lib)
install(FILES ../sources/bzlib.h DESTINATION include)
