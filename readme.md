## Run
```
docker run -it \
-p 80:80 \
-p 4501:22 \
-v /data/git/aijl2008/laravel-docker/src/log/mongodb:/var/log/mongodb \
-v /data/git/aijl2008/laravel-docker/src/log/mysqld.log:/var/log/mysqld.log \
-v /data/git/aijl2008/laravel-docker/src/log/nginx:/var/log/nginx \
-v /data/git/aijl2008/laravel-docker/src/log/php-fpm:/var/log/php-fpm \
-v /data/git/aijl2008/laravel-docker/src/log/php:/var/log/php \
-v /data/git/aijl2008/laravel-docker/src/log/redis:/var/log/redis \
-v /data/git/aijl2008/laravel-docker/src/log/supervisor:/var/log/supervisor \
-v /data/git/aijl2008/laravel-docker/src/etc/nginx:/etc/nginx \
-v /data/git/aijl2008/laravel-docker/src/etc/php-fpm.conf:/etc/php-fpm.conf \
-v /data/git/aijl2008/laravel-docker/src/etc/php-fpm.d:/etc/php-fpm.d \
-v /data/git/aijl2008/laravel-docker/src/etc/php.ini:/etc/php.ini \
-v /data/git/aijl2008/laravel-docker/src/etc/php.d:/etc/php.d \
-v /data/git/aijl2008/laravel-docker/src/etc/redis.conf:/etc/redis.conf \
-v /data/git/aijl2008/laravel-docker/src/etc/supervisord.conf:/etc/supervisord.conf \
-v /data/git/aijl2008/laravel-docker/src/etc/supervisord.d:/etc/supervisord.d \
-v /data/git/aijl2008/laravel-docker/src/etc/my.cnf:/etc/my.cnf \
-v /data/git/aijl2008/laravel-docker/src/etc/mongod.conf:/etc/mongod.cnf \
-v /data/git/aijl2008/laravel-docker/src/var/lib/mongodb:/var/lib/mongodb \
-v /data/git/aijl2008/laravel-docker/src/var/lib/mysql:/var/lib/mysql \
-v /data/git/aijl2008/laravel-docker/src/var/lib/redis:/var/lib/redis \
-v /data/git/aijl2008/laravel-docker/src/webroot:/data/webroot \
laraveldocker_web /bin/bash
laraveldocker_web /usr/bin/supervisord -c /etc/supervisord.conf
```

```
docker run -d \
--name your-app-name \
--privileged=true \
-v /data/git/aijl2008/laravel-docker//data/git/aijl2008/laravel-docker/src/etc/supervisord.d:/etc/supervisord.d \
laraveldocker_web /usr/bin/supervisord -c /etc/supervisord.conf
```
## Login Container
```
docker exex -it your-app-name /bin/bash

```# laravel-docker
