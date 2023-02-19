FROM alpine:3.15

ENV LIGHTTPD_VERSION=1.4.64-r0
ENV PHP_VERSION=7.4.33-r0

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
    php7=${PHP_VERSION} \
    php7-common=${PHP_VERSION} \
#    php7-apache2=${PHP_VERSION} \
#    php7-apcu=5.1.11-r2 \
#    php7-bcmath=${PHP_VERSION} \
#    php7-brotli-0.11.1-r0 \
    php7-bz2=${PHP_VERSION} \
#    php7-calendar=${PHP_VERSION} \
    php7-cgi=${PHP_VERSION} \
    php7-ctype=${PHP_VERSION} \
    php7-curl=${PHP_VERSION} \
#    php7-dba=${PHP_VERSION} \
#    php7-dbg=${PHP_VERSION} \
#    php7-dev=${PHP_VERSION} \
#    php7-doc=${PHP_VERSION} \
#    php7-dom=${PHP_VERSION} \
#    php7-embed=${PHP_VERSION} \
#    php7-enchant=${PHP_VERSION} \
    php7-exif=${PHP_VERSION} \
    php7-ffi=${PHP_VERSION} \
    php7-fileinfo=${PHP_VERSION} \
    php7-fpm=${PHP_VERSION} \
#    php7-ftp=${PHP_VERSION} \
    php7-gd=${PHP_VERSION} \
    php7-gettext=${PHP_VERSION} \
#    php7-gmp=${PHP_VERSION} \
    php7-iconv=${PHP_VERSION} \
#    php7-imap=${PHP_VERSION} \
    php7-intl=${PHP_VERSION} \
    php7-json=${PHP_VERSION} \
#    php7-ldap=${PHP_VERSION} \
#    php7-litespeed=${PHP_VERSION} \
    php7-mbstring=${PHP_VERSION} \    
    php7-mysqli=${PHP_VERSION} \
#    php7-mysqlnd=${PHP_VERSION} \
#    php7-odbc=${PHP_VERSION} \
    php7-opcache=${PHP_VERSION} \
    php7-openssl=${PHP_VERSION} \
#    php7-pcntl=${PHP_VERSION} \
    php7-pdo=${PHP_VERSION} \
#    php7-pdo_dblib=${PHP_VERSION} \
    php7-pdo_mysql=${PHP_VERSION} \
#    php7-pdo_odbc=${PHP_VERSION} \
#    php7-pdo_pgsql=${PHP_VERSION} \
    php7-pdo_sqlite=${PHP_VERSION} \
    php7-pear=${PHP_VERSION} \
#    php7-pecl-amqp=1.11.0-r0\
#    php7-pecl-apcu=5.1.21-r0 \
#    php7-pecl-ast=1.0.16-r0 \
#    php7-pecl-couchbase=3.2.2-r0 \
#    php7-pecl-event=3.0.6-r0 \
#    php7-pecl-gmagick=2.0.6_rc1-r1 \
#    php7-pecl-igbinary=3.2.6-r0 \
#    php7-pecl-imagick=3.6.0-r0 \
#    php7-pecl-imagick-dev=3.6.0-r0 \
#    php7-pecl-lzf=1.6.8-r1 \
#    php7-pecl-mailparse=3.1.3-r0 \
#    php7-pecl-maxminddb=1.11.0-r0 \
    php7-pecl-mcrypt=1.0.4-r0 \
#    php7-pecl-memcache=4.0.5.2-r1 \
    php7-pecl-memcached=3.1.5-r2 \
    php7-pecl-mongodb=1.11.1-r0 \
#    php7-pecl-msgpack=2.2.0_rc1-r0 \
    php7-pecl-oauth=2.0.7-r1 \
#    php7-pecl-protobuf=3.19.1-r0 \
#    php7-pecl-psr=1.1.0-r0 \
#    php7-pecl-rdkafka=5.0.2-r0 \
#    php7-pecl-redis=5.3.6-r0 \
#    php7-pecl-ssh2=1.3.1-r0 \
#    php7-pecl-timezonedb=2021.5-r0 \
    php7-pecl-uploadprogress=2.0.2-r0 \
#    php7-pecl-uploadprogress-doc=2.0.2-r0 \
    php7-pecl-uuid=1.2.0-r0 \
#    php7-pecl-vips=1.0.12-r0 \
#    php7-pecl-xdebug=3.1.4-r0 \
#    php7-pecl-xhprof=2.3.5-r0 \
#    php7-pecl-xhprof-assets=2.3.5-r0 \
    php7-pecl-yaml=2.2.2-r0 \
#    php7-pecl-zmq=1.1.3-r8 \
#    php7-pecl-zstd=0.11.0-r0 \
#    php7-pgsql=${PHP_VERSION} \
#    php7-phalcon=4.1.2-r0 \
#    php7-phar=${PHP_VERSION} \
#    php7-phpdbg=${PHP_VERSION} \
#    php7-posix=${PHP_VERSION} \
#    php7-pspell=${PHP_VERSION} \
    php7-session=${PHP_VERSION} \
#    php7-shmop=${PHP_VERSION} \
    php7-simplexml=${PHP_VERSION} \
#    php7-snmp=${PHP_VERSION} \
#    php7-soap=${PHP_VERSION} \
#    php7-sockets=${PHP_VERSION} \
#    php7-sodium=${PHP_VERSION} \
    php7-sqlite3=${PHP_VERSION} \
#    php7-suhosin=${PHP_VERSION} \
#    php7-sysvmsg=${PHP_VERSION} \
#    php7-sysvsem=${PHP_VERSION} \
#    php7-sysvshm=${PHP_VERSION} \
#    php7-tideways_xhprof=5.0.4-r0 \
#    php7-tidy=${PHP_VERSION} \
#    php7-tokenizer=${PHP_VERSION} \
    php7-xml=${PHP_VERSION} \
#    php7-xmlreader=${PHP_VERSION} \
#    php7-xmlrpc=${PHP_VERSION} \
#    php7-xmlwriter=${PHP_VERSION} \
#    php7-xsl=${PHP_VERSION} \    
    php7-zip=${PHP_VERSION} \
  && rm -rf /var/cache/apk/* \
  && mkdir -p /run/lighttpd/ && chown "${USER_ALIAS}":"${GROUP_ALIAS}" /run/lighttpd  \
  && mkdir -p /var/lib/lighttpd/cache/compress && chown -R "${USER_ALIAS}":"${GROUP_ALIAS}" /var/lib/lighttpd \  
  && mkdir -p /var/log/php && chown "${USER_ALIAS}":"${GROUP_ALIAS}" /var/log/php \
  && chmod +x /usr/local/bin/start.sh

USER ${USER_ALIAS}

EXPOSE 80

VOLUME /var/www/localhost/htdocs
VOLUME /etc/lighttpd
VOLUME /etc/php7

CMD ["start.sh"]
