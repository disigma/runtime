cmake_minimum_required(VERSION 3.0)

include(../../cmake/Me.cmake)

me_project(
    python-3.7.4 3RD INSTALL
    LIBNAME python3.7m
    DEPENDS
    libressl-2.9.2--ssl
    zlib-1.2.11
    libffi-3.2.1
)

set(ZLIB_INCLUDE ${zlib-1.2.11-PREFIX}/include)
set(ZLIB_LIBRARY ${zlib-1.2.11-LIBS})
set(FFI_INCLUDE ${libffi-3.2.1-PREFIX}/lib/libffi-3.2.1/include)
set(FFI_LIBRARY ${libffi-3.2.1-LIBS})
configure_file(cmake/Setup.local ${ME_BUILD_DIR}/Modules/Setup.local @ONLY)

me_autoconf(LIBTOOL)
me_configure(
    FLAGS
    --build=x86_64
    --disable-ipv6
    --without-ensurepip
    --with-system-ffi
    --enable-optimizations
    --with-lto
    --without-dtrace
    --without-doc-strings
    ENV "CONFIG_SITE=${CMAKE_CURRENT_LIST_DIR}/cmake/config.site"
    NO_PIC NO_STATIC NO_SYSROOT NO_HOST
)
me_make(
    ENV "PATH=${CMAKE_CURRENT_LIST_DIR}/cmake:$ENV{PATH}"
    OUTPUT make ${ME_INSTALL_PREFIX}/bin/python3.7
)
