#!/bin/sh
exec php-fpm8 -D && lighttpd -D -f /etc/lighttpd/lighttpd.conf
