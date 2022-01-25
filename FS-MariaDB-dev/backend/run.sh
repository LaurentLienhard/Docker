#!/bin/bash

service php7.4-fpm start
service nginx start
service mariadb start
mysql -uroot -proot123 < configure-mariadb.sql

./vendor/bin/phinx migrate
tail -f /var/log/nginx/error.log