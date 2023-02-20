#!/bin/sh
php-fpm81 -D && lighttpd -D -f /etc/lighttpd/lighttpd.conf
