FROM alpine:3.8

ENV LIGHTTPD_VERSION=1.4.52-r0
ENV PHP_VERSION=5.6.40-r0

ARG USER_ID
ARG GROUP_ID
ENV USER_ALIAS=www-data
ENV GROUP_ALIAS=www-data

COPY start.sh /usr/local/bin/

RUN if [ "${USER_ID:-0}" -ne 0 ] && [ "${GROUP_ID:-0}" -ne 0 ]; then \
    getent passwd "${USER_ALIAS}"  && deluser "${USER_ALIAS}";  \
    getent group "${GROUP_ALIAS}" && delgroup "${GROUP_ALIAS}"; \
    addgroup -g "${GROUP_ID}" "${GROUP_ALIAS}"; \
    adduser -D -u "${USER_ID}" -G "${GROUP_ALIAS}" "${USER_ALIAS}"; \
    [ -d  /var/run/lighttpd ] && chown "${USER_ID}":"${GROUP_ID}" /var/run/lighttpd;  \
    [ -d  /var/lib/lighttpd ] && chown "${USER_ID}":"${GROUP_ID}" /var/lib/lighttpd; \
  else \
    echo "Args were not provided"; \
    ! getent group "${GROUP_ALIAS}" && addgroup -g 1000 "${GROUP_ALIAS}"; \
    ! getent passwd "${USER_ALIAS}" && adduser -D -s /bin/false -u 1000 -G "${GROUP_ALIAS}" "${USER_ALIAS}"; \
  fi \
  && apk --update --no-cache add \
    lighttpd=${LIGHTTPD_VERSION} \
    lighttpd-mod_auth \
    php5=${PHP_VERSION} \
    php5-common=${PHP_VERSION} \
#    php5-apache2=${PHP_VERSION} \
#    php5-apcu=4.0.11-r1
#    php5-bcmath=${PHP_VERSION} \
    php5-bz2=${PHP_VERSION} \
#    php5-calendar=${PHP_VERSION} \
    php5-cgi=${PHP_VERSION} \
#    php5-cli=${PHP_VERSION} \  
#    php5-ctype=${PHP_VERSION} \
    php5-curl=${PHP_VERSION} \
#    php5-dba=${PHP_VERSION} \
#    php5-dbg=${PHP_VERSION} \
#    php5-dev=${PHP_VERSION} \
#    php5-doc=${PHP_VERSION} \
#    php5-dom=${PHP_VERSION} \
#    php5-embed=${PHP_VERSION} \
#    php5-enchant=${PHP_VERSION} \
    php5-exif=${PHP_VERSION} \
    php5-fpm=${PHP_VERSION} \
#    php5-ftp=${PHP_VERSION} \
    php5-gd=${PHP_VERSION} \
#    php5-gettext=${PHP_VERSION} \
#    php5-gmp=${PHP_VERSION} \
#    php5-iconv=${PHP_VERSION} \
#    php5-imap=${PHP_VERSION} \
#    php5-intl=${PHP_VERSION} \
    php5-json=${PHP_VERSION} \
#    php5-ldap=${PHP_VERSION} \
    php5-mcrypt=${PHP_VERSION} \
#    php5-mssql=${PHP_VERSION} \
    php5-mysql=${PHP_VERSION} \
    php5-mysqli=${PHP_VERSION} \
#    php5-mysqlnd=${PHP_VERSION} \
#    php5-odbc=${PHP_VERSION} \
    php5-opcache=${PHP_VERSION} \
    php5-openssl=${PHP_VERSION} \
#    php5-pcntl=${PHP_VERSION} \
    php5-pdo=${PHP_VERSION} \
#    php5-pdo_dblib=${PHP_VERSION} \
    php5-pdo_mysql=${PHP_VERSION} \
#    php5-pdo_odbc=${PHP_VERSION} \
#    php5-pdo_pgsql=${PHP_VERSION} \
    php5-pdo_sqlite=${PHP_VERSION} \
#    php5-pear=${PHP_VERSION} \
#    php5-pgsql=${PHP_VERSION} \
#    php5-phar=${PHP_VERSION} \
#    php5-phpdbg=${PHP_VERSION} \
#    php5-posix=${PHP_VERSION} \
#    php5-pspell=${PHP_VERSION} \
#    php5-shmop=${PHP_VERSION} \
#    php5-snmp=${PHP_VERSION} \
#    php5-soap=${PHP_VERSION} \
#    php5-sockets=${PHP_VERSION} \
    php5-sqlite3=${PHP_VERSION} \
#    php5-suhosin=${PHP_VERSION} \
#    php5-sysvmsg=${PHP_VERSION} \
#    php5-sysvsem=${PHP_VERSION} \
#    php5-sysvshm=${PHP_VERSION} \
#    php5-wddx=${PHP_VERSION} \
#    php5-xml=${PHP_VERSION} \
#    php5-xmlreader=${PHP_VERSION} \
#    php5-xmlrpc=${PHP_VERSION} \
#    php5-xsl=${PHP_VERSION} \
    php5-zip=${PHP_VERSION} \
  && rm -rf /var/cache/apk/* \ 
  && mkdir -p /run/lighttpd/ \
  && mkdir -p /var/lib/lighttpd/cache/compress \
  && mkdir -p /var/lib/lighttpd/cache \
  && chmod +x /usr/local/bin/start.sh

USER ${USER_ALIAS}

EXPOSE 80

VOLUME /var/www/localhost/htdocs
VOLUME /etc/lighttpd
VOLUME /etc/php5

CMD ["start.sh"]
