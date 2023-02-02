#!/bin/sh
php-fpm -D && lighttpd -D -f /etc/lighttpd/lighttpd.conf
