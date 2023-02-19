#!/bin/sh
php-fpm7 -D && lighttpd -D -f /etc/lighttpd/lighttpd.conf
