#!/bin/bash

service php7.4-fpm start
service nginx start
./vendor/bin/phinx migrate
tail -f /var/log/nginx/error.log