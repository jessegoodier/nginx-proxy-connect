FROM nginxinc/nginx-unprivileged:stable-alpine
LABEL maintainer "Jesse Goodier <github.com/jessegoodier>"

ENV NGINX_VERSION 1.24.0

##
# build proxy_connext
##

WORKDIR /tmp
USER 0
RUN apk update && \
    apk add       \
      alpine-sdk  \
      openssl-dev \
      pcre-dev    \
      zlib-dev

RUN curl -LSs http://nginx.org/download/nginx-${NGINX_VERSION}.tar.gz -O                                             && \
    tar xf nginx-${NGINX_VERSION}.tar.gz                                                                             && \
    cd     nginx-${NGINX_VERSION}                                                                                    && \
    git clone https://github.com/chobits/ngx_http_proxy_connect_module                                               && \
    patch -p1 < ./ngx_http_proxy_connect_module/patch/proxy_connect_rewrite_102101.patch                             && \
    ./configure                                                                                                         \
      --add-module=./ngx_http_proxy_connect_module                                                                      \
      --sbin-path=/usr/sbin/nginx                                                                                       \
      --with-cc-opt='-g -O2 -fstack-protector-strong -Wformat -Werror=format-security -Wp,-D_FORTIFY_SOURCE=2 -fPIC' && \
    make -j $(nproc)                                                                                                 && \
    make install                                                                                                     && \
    rm -rf /tmp/*  /docker-entrypoint.d docker-entrypoint.sh

##
# application deployment
##
COPY ./nginx.conf /etc/nginx
USER nginx
WORKDIR /

EXPOSE 3128
ENTRYPOINT []
CMD ["nginx", "-c", "/etc/nginx/nginx.conf", "-g", "daemon off;"]