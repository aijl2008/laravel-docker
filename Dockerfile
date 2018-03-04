FROM centos:7
MAINTAINER Jerry Ai <awz@awz.cn>
RUN mkdir /src
RUN curl -o /etc/yum.repos.d/CentOS-Base.repo http://mirrors.aliyun.com/repo/Centos-7.repo
RUN rpm -Uvh https://mirror.webtatic.com/yum/el7/epel-release.rpm
RUN rpm -Uvh https://mirror.webtatic.com/yum/el7/webtatic-release.rpm
RUN yum makecache

# install base app
RUN yum install -y net-tools wget initscripts

# install openssh-server
RUN yum install -y openssh openssh-clients openssh-server
RUN /usr/sbin/sshd-keygen -A
#RUN sed -ri 's/#PermitRootLogin\s+.*/PermitRootLogin yes/' /etc/ssh/sshd_config
RUN systemctl enable sshd.service
RUN echo 'root:123456' |chpasswd


# install supervisor
RUN yum install -y supervisor
RUN sed -i "s/;[inet_http_server]/[inet_http_server]/" /etc/supervisord.conf && \
sed -i "s/;port=127.1.0.1:9001/port=0.0.0.0:9999/" /etc/supervisord.conf

# install redis
RUN yum install -y redis
RUN sed -i "s/bind 127.0.0.1/bind 0.0.0.0/" /etc/redis.conf
RUN systemctl enable redis.service

# install mysql
RUN rpm -Uvh http://dev.mysql.com/get/mysql57-community-release-el7-8.noarch.rpm
RUN yum -y install mysql-community-server
RUN systemctl enable mysqld.service


# install nginx
RUN yum install -y nginx
RUN systemctl enable nginx.service
RUN	echo "<?php phpinfo();" > /usr/share/nginx/html/phpinfo.php


# install mongodb
RUN yum install -y mongodb mongodb-server
RUN sed -i "s/bind_ip = 127.0.0.1/bind_ip = 0.0.0.0/" /etc/mongod.conf
RUN systemctl enable mongod.service

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
RUN sed -i "s/error_reporting = .*/error_reporting = E_ALL/" /etc/php.ini && \
    sed -i "s/display_errors = .*/display_errors = On/" /etc/php.ini && \
    sed -i "s/;date.timezone.*/date.timezone = Asia\/Shanghai/" /etc/php.ini

RUN /sbin/useradd php-fpm
RUN sed -i -e "s/user = .*/user = php-fpm/" /etc/php-fpm.d/www.conf && \
    sed -i -e "s/group = .*/group = php-fpm/" /etc/php-fpm.d/www.conf

RUN systemctl enable php-fpm.service

# install composer
RUN curl -sS https://getcomposer.org/installer | php
RUN mv composer.phar /usr/local/bin/composer

WORKDIR /var/www/html/
EXPOSE 22 80 443 3306 6379 5000 9999 27017

ENTRYPOINT ["/bin/bash","-c"]
CMD ["/usr/bin/supervisord"]
