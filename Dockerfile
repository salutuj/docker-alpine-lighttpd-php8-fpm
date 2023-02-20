FROM alpine:3.17

ENV LIGHTTPD_VERSION=1.4.67-r0
ENV PHP_VERSION=8.1.16-r0

ARG USER_ID
ARG GROUP_ID
ENV USER_ALIAS=lighttpd
ENV GROUP_ALIAS=lighttpd

COPY start.sh /usr/local/bin/

RUN if [ "${USER_ID:-0}" -ne 0 ] && [ "${GROUP_ID:-0}" -ne 0 ]; then \
    getent passwd "${USER_ALIAS}" && deluser "${USER_ALIAS}";  \
    getent group "${GROUP_ALIAS}" && delgroup "${GROUP_ALIAS}"; \
    addgroup -g "${GROUP_ID}" "${GROUP_ALIAS}"; \
    adduser -D -u "${USER_ID}" -G "${GROUP_ALIAS}" "${USER_ALIAS}"; \
  else \
    echo "Args USER_ID and GROUP_ID were not provided"; \
    ! getent group "${GROUP_ALIAS}" && addgroup -g 1000 "${GROUP_ALIAS}"; \
    ! getent passwd "${USER_ALIAS}" && adduser  -u 1000 -D -s /bin/false  -G "${GROUP_ALIAS}" "${USER_ALIAS}"; \
  fi \
  && apk --update --no-cache add \
    busybox-suid \
    lighttpd=${LIGHTTPD_VERSION} \
    lighttpd-mod_auth \
    php81=${PHP_VERSION} \
    php81-common=${PHP_VERSION} \
#    php81-apache2=${PHP_VERSION} \
#    php81-bcmath=${PHP_VERSION} \
#    php81-brotli-0.11.1-r0 \
    php81-bz2=${PHP_VERSION} \
#    php81-calendar=${PHP_VERSION} \
    php81-cgi=${PHP_VERSION} \
    php81-ctype=${PHP_VERSION} \
    php81-curl=${PHP_VERSION} \
#    php81-dba=${PHP_VERSION} \
#    php81-dev=${PHP_VERSION} \
#    php81-doc=${PHP_VERSION} \
#    php81-dom=${PHP_VERSION} \
#    php81-embed=${PHP_VERSION} \
#    php81-enchant=${PHP_VERSION} \
    php81-exif=${PHP_VERSION} \
    php81-ffi=${PHP_VERSION} \
    php81-fileinfo=${PHP_VERSION} \
    php81-fpm=${PHP_VERSION} \
#    php81-ftp=${PHP_VERSION} \
    php81-gd=${PHP_VERSION} \
    php81-gettext=${PHP_VERSION} \
#    php81-gmp=${PHP_VERSION} \
    php81-iconv=${PHP_VERSION} \
#    php81-imap=${PHP_VERSION} \
    php81-intl=${PHP_VERSION} \    
#    php81-ldap=${PHP_VERSION} \
#    php81-litespeed=${PHP_VERSION} \
    php81-mbstring=${PHP_VERSION} \    
    php81-mysqli=${PHP_VERSION} \
#    php81-mysqlnd=${PHP_VERSION} \
#    php81-odbc=${PHP_VERSION} \
    php81-opcache=${PHP_VERSION} \
    php81-openssl=${PHP_VERSION} \
#    php81-pcntl=${PHP_VERSION} \
    php81-pdo=${PHP_VERSION} \
#    php81-pdo_dblib=${PHP_VERSION} \
    php81-pdo_mysql=${PHP_VERSION} \
#    php81-pdo_odbc=${PHP_VERSION} \
#    php81-pdo_pgsql=${PHP_VERSION} \
    php81-pdo_sqlite=${PHP_VERSION} \
    php81-pear=${PHP_VERSION} \
#    php81-pecl-amqp=1.11.0-r0\
#    php81-pecl-apcu=5.1.22-r0 \
#    php81-pecl-ast=1.1.0-r0 \
#    php81-pecl-couchbase=4.0.0-r1 \
#    php81-pecl-event=3.0.8-r1 \
#    php81-pecl-gmagick=2.0.6_rc1-r1 \
#    php81-pecl-igbinary=3.2.12-r0 \
#    php81-pecl-imagick=3.7.0-r0 \
#    php81-pecl-imagick-dev=3.7.0-r0 \
#    php81-pecl-lzf=1.7.0-r0 \
#    php81-pecl-mailparse=3.1.4-r0 \
#    php81-pecl-maxminddb=1.11.0-r0 \    
#    php81-pecl-memcache=8.0-r0 \
    php81-pecl-memcached=3.2.0-r0 \
    php81-pecl-mongodb=1.15.1-r0 \
#    php81-pecl-msgpack=2.2.0_rc2-r0 \    
#    php81-pecl-protobuf=3.21.7-r0 \
#    php81-pecl-psr=1.2.0-r0 \
#    php81-pecl-rdkafka=6.0.3-r0 \
#    php81-pecl-redis=5.3.7-r0 \
#    php81-pecl-ssh2=1.3.1-r0 \
#    php81-pecl-swoole=5.0.1-r0 \
#    php81-pecl-swoole-dev=5.0.1-r0 \
    php81-pecl-uploadprogress=2.0.2-r0 \
#    php81-pecl-uploadprogress-doc=2.0.2-r0 \
    php81-pecl-uuid=1.2.0-r0 \
#    php81-pecl-vips=1.0.13-r0 \
#    php81-pecl-xdebug=3.2.0-r0 \
#    php81-pecl-xhprof=2.3.9-r0 \
#    php81-pecl-xhprof-assets=2.3.9-r0 \
    php81-pecl-yaml=2.2.2-r0 \
#    php81-pecl-zstd=0.12.0-r0 \
#    php81-pgsql=${PHP_VERSION} \
#    php81-phar=${PHP_VERSION} \
#    php81-phpdbg=${PHP_VERSION} \
#    php81-posix=${PHP_VERSION} \
#    php81-pspell=${PHP_VERSION} \
    php81-session=${PHP_VERSION} \
#    php81-shmop=${PHP_VERSION} \
    php81-simplexml=${PHP_VERSION} \
#    php81-snmp=${PHP_VERSION} \
#    php81-soap=${PHP_VERSION} \
#    php81-sockets=${PHP_VERSION} \
#    php81-sodium=${PHP_VERSION} \
    php81-sqlite3=${PHP_VERSION} \
#    php81-sysvmsg=${PHP_VERSION} \
#    php81-sysvsem=${PHP_VERSION} \
#    php81-sysvshm=${PHP_VERSION} \
#    php81-tidy=${PHP_VERSION} \
#    php81-tokenizer=${PHP_VERSION} \
    php81-xml=${PHP_VERSION} \
#    php81-xmlreader=${PHP_VERSION} \
#    php81-xmlwriter=${PHP_VERSION} \
#    php81-xsl=${PHP_VERSION} \    
    php81-zip=${PHP_VERSION} \
  && rm -rf /var/cache/apk/* \
  && mkdir -p /run/lighttpd/ && chown "${USER_ALIAS}":"${GROUP_ALIAS}" /run/lighttpd  \
  && mkdir -p /var/lib/lighttpd/cache/compress && chown -R "${USER_ALIAS}":"${GROUP_ALIAS}" /var/lib/lighttpd \  
  && mkdir -p /var/log/php && chown "${USER_ALIAS}":"${GROUP_ALIAS}" /var/log/php \
  && chmod +x /usr/local/bin/start.sh

USER ${USER_ALIAS}

EXPOSE 80

VOLUME /var/www/localhost/htdocs
VOLUME /etc/lighttpd
VOLUME /etc/php81

CMD ["start.sh"]
