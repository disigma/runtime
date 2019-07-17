cmake_minimum_required(VERSION 3.0)

include(../../cmake/Me.cmake)

me_project(
    uwsgi-2.0.18 3RD INSTALL
    DEPENDS
    python-3.7.4
    pcre-8.43
    expat-2.2.7
    zlib-1.2.11
    libressl-2.9.2--ssl
)

file(COPY sources/ DESTINATION ${ME_BUILD_DIR} USE_SOURCE_PERMISSIONS)
file(COPY cmake/local.ini DESTINATION ${ME_BUILD_DIR}/buildconf USE_SOURCE_PERMISSIONS)

string(
    CONCAT LDFLAGS
    "-L${python-3.7.4-PREFIX}/lib "
    "-L${pcre-8.43-PREFIX}/lib "
    "-L${expat-2.2.7-PREFIX}/lib "
    "-L${zlib-1.2.11-PREFIX}/lib "
    "-L${libressl-2.9.2-PREFIX}/lib "
    "-lpython3.7m "
)

set(CMAKE_POLICY_DEFAULT_CMP0058 NEW CACHE STRING CMAKE_POLICY_DEFAULT_CMP0058)

me_configure(
    NO_FLAGS NO_INLINE_ENV
    OUTPUT ${ME_BUILD_DIR}/uwsgi
    ENV
    "LDFLAGS=${LDFLAGS}"
    CFLAGS
    "-I${python-3.7.4-PREFIX}/include/python3.7m"
    "-I${pcre-8.43-PREFIX}/include"
    "-I${expat-2.2.7-PREFIX}/include"
    "-I${zlib-1.2.11-PREFIX}/include"
    "-I${libressl-2.9.2-PREFIX}/include"
    FILE "${python-3.7.4-PREFIX}/bin/python3.7"
    FLAGS ${ME_SOURCE_DIR}/uwsgiconfig.py -b local
)
add_custom_command(
    OUTPUT make
    COMMENT "[${ME_PROJECT}] make"
    COMMAND ${CMAKE_COMMAND} -E make_directory ${ME_INSTALL_PREFIX}/bin
    COMMAND ${CMAKE_COMMAND} -E copy_if_different ${ME_BUILD_DIR}/uwsgi ${ME_INSTALL_PREFIX}/bin/
    DEPENDS ${ME_BUILD_DIR}/uwsgi
)
