cmake_minimum_required(VERSION 3.0)

include(../../cmake/Me.cmake)

me_project(
    nginx-1.17.1 3RD INSTALL
    DEPENDS
    pcre-8.43
    zlib-1.2.11
    libressl-2.9.2--ssl
)
file(COPY sources/ DESTINATION ${ME_BUILD_DIR} USE_SOURCE_PERMISSIONS)

string(
    CONCAT NGINX_CFLAGS
    "-I${pcre-8.43-PREFIX}/include "
    "-I${zlib-1.2.11-PREFIX}/include "
    "-I${libressl-2.9.2-PREFIX}/include "
)
string(
    CONCAT NGINX_LDFLAGS
    "-L${pcre-8.43-PREFIX}/lib "
    "-L${zlib-1.2.11-PREFIX}/lib "
    "-L${libressl-2.9.2-PREFIX}/lib "
)
me_configure(
    FLAGS
    "--with-cc-opt=${NGINX_CFLAGS}"
    "--with-ld-opt=${NGINX_LDFLAGS}"
    "--build=${ME_TRIPLE}"
    "--with-file-aio"
    "--with-http_addition_module"
    "--with-http_auth_request_module"
    "--with-http_dav_module"
    "--with-http_degradation_module"
    "--with-http_flv_module"
    "--with-http_gunzip_module"
    "--with-http_gzip_static_module"
    "--with-http_mp4_module"
    "--with-http_random_index_module"
    "--with-http_random_index_module"
    "--with-http_realip_module"
    "--with-http_secure_link_module"
    "--with-http_slice_module"
    "--with-http_ssl_module"
    "--with-http_stub_status_module"
    "--with-http_sub_module"
    "--with-http_v2_module"
    "--with-pcre"
    "--with-pcre-jit"
    "--with-stream=dynamic"
    "--with-stream_ssl_module"
    "--with-threads"
    NO_HOST NO_PIC NO_SYSROOT NO_STATIC NO_INLINE_ENV
)
me_make()
