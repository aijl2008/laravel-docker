FROM centos:7
MAINTAINER Jerry Ai <awz@awz.cn>
RUN curl -o /etc/yum.repos.d/CentOS-Base.repo http://mirrors.aliyun.com/repo/Centos-7.repo
RUN rpm -Uvh https://mirror.webtatic.com/yum/el7/epel-release.rpm
RUN rpm -Uvh https://mirror.webtatic.com/yum/el7/webtatic-release.rpm
RUN yum makecache

# install base app
RUN yum install -y net-tools wget initscripts

# install openssh-server
RUN yum install -y openssh openssh-clients openssh-server
RUN /usr/sbin/sshd-keygen -A
RUN echo 'root:123456' |chpasswd


# install supervisor
RUN yum install -y supervisor

# install redis
RUN yum install -y redis

# install mysql
RUN rpm -Uvh http://dev.mysql.com/get/mysql57-community-release-el7-8.noarch.rpm
RUN yum -y install mysql-community-server
RUN cat /etc/my.cnf
RUN rm -rf /var/lib/mysql
RUN mysqld --initialize-insecure --datadir=/var/lib/mysql

# install nginx
RUN yum install -y nginx

# install mongodb
RUN yum install -y mongodb mongodb-server

# install php
RUN yum -y install  php71w \
                    php71w-cli \
                    php71w-fpm \
                    php71w-common \
                    php71w-mbstring \
                    php71w-imap \
                    php71w-gd \
                    php71w-mcrypt \
                    php71w-mysqlnd \
                    php71w-pdo \
                    php71w-pear \
                    php71w-pecl-imagick \
                    php71w-pecl-memcached \
                    php71w-pecl-mongodb \
                    php71w-pecl-redis \
                    php71w-pecl-xdebug \
                    php71w-tidy \
                    php71w-xml \
                    php71w-xmlrpc

RUN /sbin/useradd php-fpm
RUN /bin/mkdir /var/log/php


# install composer
RUN curl -sS https://getcomposer.org/installer | php
RUN ls -al
RUN mv composer.phar /usr/local/bin/composer
RUN composer global config -g repo.packagist composer https://packagist.phpcomposer.com
RUN composer global config secure-http false

# install vcs
RUN yum install -y subversion git

WORKDIR /var/www/html/
EXPOSE 22 80 443 3306 6379 9999 27017

CMD ["supervisord","-n","-c","/etc/supervisord.conf"]
