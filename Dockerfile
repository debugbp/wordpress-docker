FROM alpine:3.16

RUN apk --update add lighttpd mariadb mariadb-client php php-fpm php-common php-json php-mysqli php-curl php-dom php-exif php-fileinfo php8-pecl-imagick php-mbstring php-openssl php-xml php-zip curl jq procps

ADD lighttpd.conf /etc/lighttpd

ADD wordpress.sql /opt
ADD init-db.sh /opt
RUN /opt/init-db.sh

ADD wordpress.tar.gz /var/www

ADD export.sh /etc/periodic/15min
ADD entrypoint.sh /opt

ENTRYPOINT ["/opt/entrypoint.sh"]
