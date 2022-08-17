#!/bin/sh

[ "$1" == "crond" ] && crond
cd '/usr' ; ( /usr/bin/mysqld_safe --skip-networking --datadir='/var/lib/mysql' &)
sleep 10s
/usr/sbin/php-fpm8
sleep 1s
sed -i 's/${PORT}/'"$PORT"'/g' /etc/lighttpd/lighttpd.conf
/usr/sbin/lighttpd -f /etc/lighttpd/lighttpd.conf -D
