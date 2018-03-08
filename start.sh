#!/bin/sh
pwd=`pwd`/src
tag="laravel"
ip="0.0.0.0"
if [ $1 ];then
    ip=$1
fi
echo $2
if [ $2 ];then
    pwd=$2
fi
if [ $3 ];then
    tag=$3
fi
docker run -d \
--name ${tag} \
-p ${ip}:80:80 \
-p ${ip}:443:443 \
-p ${ip}:3306:3308 \
-p ${ip}:9999:9999 \
-p ${ip}:27017:27017 \
-p ${ip}:4501:22 \
-v ${pwd}/log/mongodb:/var/log/mongodb \
-v ${pwd}/log/mysqld.log:/var/log/mysqld.log \
-v ${pwd}/log/nginx:/var/log/nginx \
-v ${pwd}/log/php-fpm:/var/log/php-fpm \
-v ${pwd}/log/php:/var/log/php \
-v ${pwd}/log/redis:/var/log/redis \
-v ${pwd}/log/supervisor:/var/log/supervisor \
-v ${pwd}/etc/nginx:/etc/nginx \
-v ${pwd}/etc/php-fpm.conf:/etc/php-fpm.conf \
-v ${pwd}/etc/php-fpm.d:/etc/php-fpm.d \
-v ${pwd}/etc/php.ini:/etc/php.ini \
-v ${pwd}/etc/php.d:/etc/php.d \
-v ${pwd}/etc/redis.conf:/etc/redis.conf \
-v ${pwd}/etc/supervisord.conf:/etc/supervisord.conf \
-v ${pwd}/etc/supervisord.d:/etc/supervisord.d \
-v ${pwd}/etc/my.cnf:/etc/my.cnf \
-v ${pwd}/etc/mongod.conf:/etc/mongod.cnf \
-v ${pwd}/var/lib/mongodb:/var/lib/mongodb \
-v ${pwd}/var/lib/mysql:/var/lib/mysql \
-v ${pwd}/var/lib/redis:/var/lib/redis \
-v ${pwd}/webroot:/data/webroot \
artron/laravel-docker:1.1
