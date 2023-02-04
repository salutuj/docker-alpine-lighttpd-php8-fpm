#!/bin/sh
php-fpm5 -D && lighttpd -D -f /etc/lighttpd/lighttpd.conf
