cmake_minimum_required(VERSION 3.0)

include(../../cmake/Me.cmake)

me_project(
    python-3.7.4 3RD
    LIBNAME python3.7m
    DEPENDS
    libressl-2.9.2--ssl
    zlib-1.2.11
    libffi-3.2.1
    expat-2.2.7
    xz-5.2.4
    readline-8.0
    ncurses-6.1
    bzip2-1.0.8
    sqlite3-3.29
    uuid-1.0.3
)

set(ZLIB_INCLUDE ${zlib-1.2.11-PREFIX}/include)
set(ZLIB_LIBRARY ${zlib-1.2.11-LIBS})
set(FFI_INCLUDE ${libffi-3.2.1-PREFIX}/lib/libffi-3.2.1/include)
set(FFI_LIBRARY ${libffi-3.2.1-LIBS})
set(SQLITE3_INCLUDE ${sqlite3-3.29-PREFIX}/include)
set(SQLITE3_EXTRA_INCLUDE ${CMAKE_CURRENT_LIST_DIR}/cmake/sqlite3)
set(SQLITE3_LIBRARY ${sqlite3-3.29-LIBS})
set(UUID_INCLUDE ${uuid-1.0.3-PREFIX}/include)
set(UUID_LIBRARY ${uuid-1.0.3-LIBS})
configure_file(cmake/Setup.local ${ME_BUILD_DIR}/Modules/Setup.local @ONLY)

set(
    PYTHON_CCFLAG_LIST
    "-I${libressl-2.9.2-PREFIX}/include"
    "-I${zlib-1.2.11-PREFIX}/include"
    "-I${libffi-3.2.1-PREFIX}/include"
    "-I${expat-2.2.7-PREFIX}/include"
    "-I${xz-5.2.4-PREFIX}/include"
    "-I${readline-8.0-PREFIX}/include"
    "-I${ncurses-6.1-PREFIX}/include/ncurses"
    "-I${ncurses-6.1-PREFIX}/include"
    "-I${bzip2-1.0.8-PREFIX}/include"
)
foreach(ccflag ${PYTHON_CCFLAG_LIST})
    string(CONCAT PYTHON_CCFLAGS ${PYTHON_CCFLAGS} " " ${ccflag})
endforeach()

set(
    PYTHON_LDFLAG_LIST
    "-L${libressl-2.9.2-PREFIX}/lib"
    "-L${zlib-1.2.11-PREFIX}/lib"
    "-L${libffi-3.2.1-PREFIX}/lib"
    "-L${expat-2.2.7-PREFIX}/lib"
    "-L${xz-5.2.4-PREFIX}/lib"
    "-L${readline-8.0-PREFIX}/lib"
    "-L${ncurses-6.1-PREFIX}/lib"
    "-L${bzip2-1.0.8-PREFIX}/lib"
)
foreach(ldflag ${PYTHON_LDFLAG_LIST})
    string(CONCAT PYTHON_LDFLAGS ${PYTHON_LDFLAGS} " " ${ldflag})
endforeach()

set(
    PYTHON_LIB_LIST
    "${readline-8.0-LIBS}"
    "${ncurses-6.1-LIBS}"
    "${libffi-3.2.1-LIBS}"
    "${xz-5.2.4-LIBS}"
    "${sqlite3-3.29-LIBS}"
    "${uuid-1.0.3-LIBS}"
    -lnsl -lm -ldl -lpthread
)
foreach(lib ${PYTHON_LIB_LIST})
    string(CONCAT PYTHON_LIBS ${PYTHON_LIBS} " " ${lib})
endforeach()

me_autoconf(LIBTOOL)
me_configure(
    FLAGS
    --prefix=${ME_INSTALL_PREFIX}
    --build=x86_64
    --disable-ipv6
    --without-ensurepip
    --with-system-expat
    --with-system-ffi
    --enable-optimizations
    --with-lto
    --without-dtrace
    --without-doc-strings
    --enable-loadable-sqlite-extensions
    --with-ssl-default-suites=openssl
    "--with-libs=${PYTHON_LIBS}"
    CCFLAGS
    ${PYTHON_CCFLAG_LIST}
    ENV
    "CONFIG_SITE=${CMAKE_CURRENT_LIST_DIR}/cmake/config.site"
    "LDFLAGS=${PYTHON_LDFLAGS}"
    NO_FLAGS
)
me_make(
    ENV
    "PATH=${CMAKE_CURRENT_LIST_DIR}/cmake:$ENV{PATH}"
    "CFLAGS=${PYTHON_CCFLAGS}"
    "LDFLAGS=${PYTHON_LDFLAGS}"
    OUTPUT make ${ME_INSTALL_PREFIX}/bin/python3.7
    TARGETS build_all altinstall
)

install(
    DIRECTORY ${ME_INSTALL_PREFIX}/
    DESTINATION ${CMAKE_INSTALL_PREFIX}
    USE_SOURCE_PERMISSIONS
    COMPONENT ${ME_PROJECT}
    PATTERN __pycache__ EXCLUDE
    PATTERN pkgconfig EXCLUDE
    PATTERN libpython3.7m.a EXCLUDE
    PATTERN config-3.7m-* EXCLUDE
)
me_install_target(${ME_PROJECT})
