#!/bin/sh

mariadb-install-db --user=mysql --datadir=/var/lib/mysql
cd '/usr' ; ( /usr/bin/mysqld_safe --datadir='/var/lib/mysql' --skip-networking &)
sleep 3
mysql -e "UPDATE mysql.global_priv SET priv=json_set(priv, '$.password_last_changed', UNIX_TIMESTAMP(), '$.plugin', 'mysql_native_password', '$.authentication_string', 'invalid', '$.auth_or', json_array(json_object(), json_object('plugin', 'unix_socket'))) WHERE User='root';"
mysql -e "UPDATE mysql.global_priv SET priv=json_set(priv, '$.plugin', 'mysql_native_password', '$.authentication_string', PASSWORD('$(cat /dev/urandom | tr -dc 'a-zA-Z0-9' | fold -w 32 | head -n 1)')) WHERE User='root';"
mysql -e "DELETE FROM mysql.global_priv WHERE User='';"
mysql -e "DELETE FROM mysql.global_priv WHERE User='root' AND Host NOT IN ('localhost', '127.0.0.1', '::1');"
mysql -e "DROP DATABASE IF EXISTS test;"

mysql -e "CREATE USER 'wp-user'@'localhost' IDENTIFIED BY 'password_here';"
mysql -e "CREATE DATABASE wordpress;"
mysql -e "GRANT ALL PRIVILEGES ON wordpress.* TO 'wp-user'@'localhost';"
mysql -e "FLUSH PRIVILEGES;"

mysql wordpress < /opt/wordpress.sql

mysqladmin shutdown
