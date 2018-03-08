#!/bin/sh
runtime_path=/data/docker/container/default
original_path=`pwd`/src
tag="laravel"
ip="0.0.0.0"
if [ $1 ];then
    ip=$1
fi
if [ $2 ];then
    runtime_path=$2
fi
if [ $3 ];then
    tag=$3
fi
if [ ! -d runtime_path ];then
 mkdir -p ${runtime_path}
fi
echo Coping \'${original_path}\' to \'${runtime_path}\' ......
cp -r ${original_path}/* ${runtime_path}
chmod -R 777 ${runtime_path}
chmod -R 644 ${runtime_path}/etc/my.cnf
chmod -R 644 ${runtime_path}/var/lib/mysql
chown -R mysql:mysql ${runtime_path}/var/lib/mysql
if [ $? -ne 0 ]
then
echo 'Failed'
exit
else
echo 'Success'
fi
echo "Running docker run -d \
--name ${tag} \
-p ${ip}:80:80 \
-p ${ip}:443:443 \
-p ${ip}:3306:3308 \
-p ${ip}:9999:9999 \
-p ${ip}:27017:27017 \
-p ${ip}:4501:22 \
-v ${runtime_path}/log/mongodb:/var/log/mongodb \
-v ${runtime_path}/log/mysqld.log:/var/log/mysqld.log \
-v ${runtime_path}/log/nginx:/var/log/nginx \
-v ${runtime_path}/log/php-fpm:/var/log/php-fpm \
-v ${runtime_path}/log/php:/var/log/php \
-v ${runtime_path}/log/redis:/var/log/redis \
-v ${runtime_path}/log/supervisor:/var/log/supervisor \
-v ${runtime_path}/etc/nginx:/etc/nginx \
-v ${runtime_path}/etc/php-fpm.conf:/etc/php-fpm.conf \
-v ${runtime_path}/etc/php-fpm.d:/etc/php-fpm.d \
-v ${runtime_path}/etc/php.ini:/etc/php.ini \
-v ${runtime_path}/etc/php.d:/etc/php.d \
-v ${runtime_path}/etc/redis.conf:/etc/redis.conf \
-v ${runtime_path}/etc/supervisord.conf:/etc/supervisord.conf \
-v ${runtime_path}/etc/supervisord.d:/etc/supervisord.d \
-v ${runtime_path}/etc/my.cnf:/etc/my.cnf \
-v ${runtime_path}/etc/mongod.conf:/etc/mongod.cnf \
-v ${runtime_path}/var/lib/mongodb:/var/lib/mongodb \
-v ${runtime_path}/var/lib/mysql:/var/lib/mysql \
-v ${runtime_path}/var/lib/redis:/var/lib/redis \
-v ${runtime_path}/webroot:/data/webroot \
artron/laravel-docker:1.0"
docker run -d \
--name ${tag} \
-p ${ip}:80:80 \
-p ${ip}:443:443 \
-p ${ip}:3306:3308 \
-p ${ip}:9999:9999 \
-p ${ip}:27017:27017 \
-p ${ip}:4501:22 \
-v ${runtime_path}/log/mongodb:/var/log/mongodb \
-v ${runtime_path}/log/mysqld.log:/var/log/mysqld.log \
-v ${runtime_path}/log/nginx:/var/log/nginx \
-v ${runtime_path}/log/php-fpm:/var/log/php-fpm \
-v ${runtime_path}/log/php:/var/log/php \
-v ${runtime_path}/log/redis:/var/log/redis \
-v ${runtime_path}/log/supervisor:/var/log/supervisor \
-v ${runtime_path}/etc/nginx:/etc/nginx \
-v ${runtime_path}/etc/php-fpm.conf:/etc/php-fpm.conf \
-v ${runtime_path}/etc/php-fpm.d:/etc/php-fpm.d \
-v ${runtime_path}/etc/php.ini:/etc/php.ini \
-v ${runtime_path}/etc/php.d:/etc/php.d \
-v ${runtime_path}/etc/redis.conf:/etc/redis.conf \
-v ${runtime_path}/etc/supervisord.conf:/etc/supervisord.conf \
-v ${runtime_path}/etc/supervisord.d:/etc/supervisord.d \
-v ${runtime_path}/etc/my.cnf:/etc/my.cnf \
-v ${runtime_path}/etc/mongod.conf:/etc/mongod.cnf \
-v ${runtime_path}/var/lib/mongodb:/var/lib/mongodb \
-v ${runtime_path}/var/lib/mysql:/var/lib/mysql \
-v ${runtime_path}/var/lib/redis:/var/lib/redis \
-v ${runtime_path}/webroot:/data/webroot \
artron/laravel-docker:1.0
if [ $? -ne 0 ]
then
echo 'Failed'
exit
else
echo 'Success'
fi
echo Please run \'docker exec -it ${tag} /bin/bash\' to enter into the container
