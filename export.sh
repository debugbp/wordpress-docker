#!/bin/sh

mysqldump --user=wp-user --password=password_here wordpress > /opt/wordpress.sql
cd /var/www; tar czvf /opt/wordpress.tar.gz wordpress
