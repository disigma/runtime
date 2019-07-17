cmake_minimum_required(VERSION 3.0)

project(zlib)

set(VERSION "1.2.11")

option(ASM686 "Enable building i686 assembly implementation")
option(AMD64 "Enable building amd64 assembly implementation")

include(CheckTypeSize)
include(CheckFunctionExists)
include(CheckIncludeFile)
include(CheckCSourceCompiles)

check_include_file(sys/types.h HAVE_SYS_TYPES_H)
check_include_file(stdint.h HAVE_STDINT_H)
check_include_file(stddef.h HAVE_STDDEF_H)
check_include_file(stdarg.h HAVE_STDARG_H)

# Check to see if we have large file support
set(CMAKE_REQUIRED_DEFINITIONS -D_LARGEFILE64_SOURCE=1)
check_type_size(off64_t OFF64_T)
if(HAVE_OFF64_T)
    add_definitions(-D_LARGEFILE64_SOURCE=1)
endif()
set(CMAKE_REQUIRED_DEFINITIONS) # clear variable

# Check for fseeko
check_function_exists(fseeko HAVE_FSEEKO)
if(NOT HAVE_FSEEKO)
    add_definitions(-DNO_FSEEKO)
endif()

# Check for unistd.h
check_include_file(unistd.h Z_HAVE_UNISTD_H)

if(MSVC)
    set(CMAKE_DEBUG_POSTFIX "d")
    add_definitions(-D_CRT_SECURE_NO_DEPRECATE)
    add_definitions(-D_CRT_NONSTDC_NO_DEPRECATE)
endif()

if(NOT CMAKE_CURRENT_SOURCE_DIR STREQUAL CMAKE_CURRENT_BINARY_DIR)
    # If we're doing an out of source build and the user has a zconf.h in their source tree...
    if(EXISTS ${CMAKE_CURRENT_SOURCE_DIR}/zconf.h)
        file(
            RENAME
            ${CMAKE_CURRENT_SOURCE_DIR}/zconf.h
            ${CMAKE_CURRENT_SOURCE_DIR}/zconf.h.included
        )
    endif()
endif()

set(INSTALL_LIB_DIR "${CMAKE_INSTALL_PREFIX}/lib")
set(INSTALL_INC_DIR "${CMAKE_INSTALL_PREFIX}/include")
set(ZLIB_PC ${CMAKE_CURRENT_BINARY_DIR}/zlib.pc)
configure_file(../sources/zlib.pc.cmakein ${ZLIB_PC} @ONLY)
configure_file(../sources/zconf.h.cmakein ${CMAKE_CURRENT_BINARY_DIR}/zconf.h @ONLY)
include_directories(../sources ${CMAKE_CURRENT_BINARY_DIR})


set(ZLIB_PUBLIC_HDRS ${CMAKE_CURRENT_BINARY_DIR}/zconf.h ../sources/zlib.h)
set(
    ZLIB_PRIVATE_HDRS
    ../sources/crc32.h
    ../sources/deflate.h
    ../sources/gzguts.h
    ../sources/inffast.h
    ../sources/inffixed.h
    ../sources/inflate.h
    ../sources/inftrees.h
    ../sources/trees.h
    ../sources/zutil.h
)
set(
    ZLIB_SRCS
    ../sources/adler32.c
    ../sources/compress.c
    ../sources/crc32.c
    ../sources/deflate.c
    ../sources/gzclose.c
    ../sources/gzlib.c
    ../sources/gzread.c
    ../sources/gzwrite.c
    ../sources/inflate.c
    ../sources/infback.c
    ../sources/inftrees.c
    ../sources/inffast.c
    ../sources/trees.c
    ../sources/uncompr.c
    ../sources/zutil.c
)

if(CMAKE_COMPILER_IS_GNUCC)
    if(ASM686)
        set(ZLIB_ASMS contrib/asm686/match.S)
    elseif(AMD64)
        set(ZLIB_ASMS contrib/amd64/amd64-match.S)
    endif()

    if(ZLIB_ASMS)
        add_definitions(-DASMV)
        set_source_files_properties(
            ${ZLIB_ASMS} PROPERTIES
            LANGUAGE C
            COMPILE_FLAGS -DNO_UNDERLINE
        )
    endif()
endif()

if(MSVC)
    if(ASM686)
        ENABLE_LANGUAGE(ASM_MASM)
        set(ZLIB_ASMS contrib/masmx86/inffas32.asm contrib/masmx86/match686.asm)
    elseif(AMD64)
        ENABLE_LANGUAGE(ASM_MASM)
        set(ZLIB_ASMS contrib/masmx64/gvmat64.asm contrib/masmx64/inffasx64.asm)
    endif()

    if(ZLIB_ASMS)
        add_definitions(-DASMV -DASMINF)
    endif()
endif()

add_library(zlib STATIC ${ZLIB_SRCS} ${ZLIB_ASMS} ${ZLIB_PUBLIC_HDRS} ${ZLIB_PRIVATE_HDRS})
# On unix-like platforms the library is almost always called libz
set_target_properties(zlib PROPERTIES OUTPUT_NAME z)

if(NOT SKIP_INSTALL_LIBRARIES AND NOT SKIP_INSTALL_ALL)
    install(TARGETS zlib DESTINATION lib)
endif()
if(NOT SKIP_INSTALL_HEADERS AND NOT SKIP_INSTALL_ALL)
    install(FILES ${ZLIB_PUBLIC_HDRS} DESTINATION include)
endif()
if(NOT SKIP_INSTALL_FILES AND NOT SKIP_INSTALL_ALL)
    install(FILES ${ZLIB_PC} DESTINATION lib/pkgconfig)
endif()
