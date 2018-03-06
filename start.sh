#!/bin/sh
pwd=`pwd`
docker run -d \
-p 80:80 \
-p 443:443 \
-p 3306:3308 \
-p 9999:9999 \
-p 27017:27017 \
-p 4501:22 \
-v ${pwd}/src/log/mongodb:/var/log/mongodb \
-v ${pwd}/src/log/mysqld.log:/var/log/mysqld.log \
-v ${pwd}/src/log/nginx:/var/log/nginx \
-v ${pwd}/src/log/php-fpm:/var/log/php-fpm \
-v ${pwd}/src/log/php:/var/log/php \
-v ${pwd}/src/log/redis:/var/log/redis \
-v ${pwd}/src/log/supervisor:/var/log/supervisor \
-v ${pwd}/src/etc/nginx:/etc/nginx \
-v ${pwd}/src/etc/php-fpm.conf:/etc/php-fpm.conf \
-v ${pwd}/src/etc/php-fpm.d:/etc/php-fpm.d \
-v ${pwd}/src/etc/php.ini:/etc/php.ini \
-v ${pwd}/src/etc/php.d:/etc/php.d \
-v ${pwd}/src/etc/redis.conf:/etc/redis.conf \
-v ${pwd}/src/etc/supervisord.conf:/etc/supervisord.conf \
-v ${pwd}/src/etc/supervisord.d:/etc/supervisord.d \
-v ${pwd}/src/etc/my.cnf:/etc/my.cnf \
-v ${pwd}/src/etc/mongod.conf:/etc/mongod.cnf \
-v ${pwd}/src/var/lib/mongodb:/var/lib/mongodb \
-v ${pwd}/src/var/lib/mysql:/var/lib/mysql \
-v ${pwd}/src/var/lib/redis:/var/lib/redis \
-v ${pwd}/src/webroot:/data/webroot \
artron/laravel-docker:1.0

