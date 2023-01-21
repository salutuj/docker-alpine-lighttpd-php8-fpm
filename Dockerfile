FROM alpine:3.16

ENV LIGHTTPD_VERSION=1.4.64-r0
ENV PHP8_VERSION=8.0.27-r0
ENV 
COPY start.sh /usr/local/bin/
RUN apk --update --no-cache add \
  lighttpd=${LIGHTTPD_VERSION} \
  lighttpd-mod_auth \
  php8=${PHP8_VERSION} \
  php8-common=${PHP8_VERSION} \
#  php8-apache2=${PHP8_VERSION} \
#  php8-bcmath=${PHP8_VERSION} \
  php8-bz2=${PHP8_VERSION} \
#  php8-calendar=${PHP8_VERSION} \
  php8-cgi=${PHP8_VERSION} \
#  php8-ctype=${PHP8_VERSION} \
  php8-curl=${PHP8_VERSION} \
#  php8-dba=${PHP8_VERSION} \
#  php8-dbg=${PHP8_VERSION} \
#  php8-dev=${PHP8_VERSION} \
#  php8-doc=${PHP8_VERSION} \
#  php8-dom=${PHP8_VERSION} \
#  php8-embed=${PHP8_VERSION} \
#  php8-enchant=${PHP8_VERSION} \
  php8-exif=${PHP8_VERSION} \
#  php8-ffi=${PHP8_VERSION} \
#php8-fileinfo=${PHP8_VERSION} \
  php8-fpm=${PHP8_VERSION} \
#  php8-ftp=${PHP8_VERSION} \
#  php8-gd=${PHP8_VERSION} \
#  php8-gettext=${PHP8_VERSION} \
#  php8-gmp=${PHP8_VERSION} \
#  php8-iconv=${PHP8_VERSION} \
#  php8-imap=${PHP8_VERSION} \
#  php8-intl=${PHP8_VERSION} \
#  php8-ldap=${PHP8_VERSION} \
#  php8-litespeed=${PHP8_VERSION} \
#  php8-mbstring=${PHP8_VERSION} \
  php8-mysqli=${PHP8_VERSION} \
#  php8-mysqlnd=${PHP8_VERSION} \
#  php8-odbc=${PHP8_VERSION} \
#  php8-opcache=${PHP8_VERSION} \
  php8-openssl=${PHP8_VERSION} \
#  php8-pcntl=${PHP8_VERSION} \
#  php8-pdo=${PHP8_VERSION} \
#  php8-pdo_dblib=${PHP8_VERSION} \
#  php8-pdo_mysql=${PHP8_VERSION} \
#  php8-pdo_odbc=${PHP8_VERSION} \
#  php8-pdo_pgsql=${PHP8_VERSION} \
#  php8-pdo_sqlite=${PHP8_VERSION} \
#  php8-pear=${PHP8_VERSION} \
#  php8-pgsql=${PHP8_VERSION} \
#  php8-phar=${PHP8_VERSION} \
#  php8-phpdbg=${PHP8_VERSION} \
#  php8-posix=${PHP8_VERSION} \
#  php8-pspell=${PHP8_VERSION} \
#  php8-session=${PHP8_VERSION} \
#  php8-shmop=${PHP8_VERSION} \
#  php8-simplexml=${PHP8_VERSION} \
#  php8-snmp=${PHP8_VERSION} \
#  php8-soap=${PHP8_VERSION} \
#  php8-sockets=${PHP8_VERSION} \
#  php8-sodium=${PHP8_VERSION} \
#  php8-sqlite3=${PHP8_VERSION} \
#  php8-sysvmsg=${PHP8_VERSION} \
#  php8-sysvsem=${PHP8_VERSION} \
#  php8-sysvshm=${PHP8_VERSION} \
#  php8-tidy=${PHP8_VERSION} \
#  php8-tokenizer=${PHP8_VERSION} \
#  php8-xml=${PHP8_VERSION} \
#  php8-xmlreader=${PHP8_VERSION} \
#  php8-xmlwriter=${PHP8_VERSION} \
#  php8-xsl=${PHP8_VERSION} \
  php8-zip=${PHP8_VERSION} \
&& rm -rf /var/cache/apk/* \ 
&& mkdir -p /run/lighttpd/ \
&& mkdir -p /var/lib/lighttpd/cache/compress \
&& mkdir -p /var/lib/lighttpd/cache \
&& chmod +x /usr/local/bin/start.sh

COPY etc/* /etc/

EXPOSE 80

VOLUME /var/www/localhost/htdocs
VOLUME /etc/lighttpd
VOLUME /etc/php8

CMD ["start.sh"]
