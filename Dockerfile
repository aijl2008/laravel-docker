FROM centos:7
MAINTAINER Jerry Ai <awz@awz.cn>
RUN mkdir /src
RUN mv /etc/yum.repos.d/CentOS-Base.repo /etc/yum.repos.d/CentOS-Base.repo.backup
COPY src/etc/yum.repos.d/CentOS-Base.repo /etc/yum.repos.d/CentOS-Base.repo
COPY src/etc/yum.repos.d/epel.repo /etc/yum.repos.d/epel.repo
#COPY src/epel-release-latest-7.noarch.rpm /src/epel-release-latest-7.noarch.rpm
COPY src/webtatic-release.rpm /src/webtatic-release.rpm
RUN rpm -ivh /src/webtatic-release.rpm
#RUN rpm -ivh /src/epel-release-latest-7.noarch.rpm
RUN yum makecache

# install base app
RUN yum install -y openssh openssh-clients net-tools

# install openssh-server
RUN yum install -y initscripts openssh-server
RUN /usr/sbin/sshd-keygen -A
#RUN sed -ri 's/#PermitRootLogin\s+.*/PermitRootLogin yes/' /etc/ssh/sshd_config
RUN systemctl enable sshd.service
RUN echo 'root:123456' |chpasswd


# install supervisor
RUN yum install supervisor
RUN sed -i "s/;[inet_http_server]/[inet_http_server]/" /etc/supervisord.conf && \
sed -i "s/;port=127.1.0.1:9001/port=0.0.0.0:9999/" /etc/supervisord.conf

# install redis
RUN yum install -y redis
RUN sed -i "s/bind 127.0.0.1/bind 0.0.0.0/" /etc/redis.conf
RUN systemctl enable redis.service

# install mysql
COPY src/mysql57-community-release-el7-8.noarch.rpm /src/mysql57-community-release-el7-8.noarch.rpm
RUN yum -y install /src/mysql57-community-release-el7-8.noarch.rpm
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
    sed -i "s/;date.timezone.*/date.timezone = Asia\/Shanghai/" /etc/php.ini && \
    sed -i "s/;cgi.fix_pathinfo=1/cgi.fix_pathinfo=0/" /etc/php/7.1/fpm/php.ini && \
    sed -i "s/upload_max_filesize = .*/upload_max_filesize = 100M/" /etc/php/7.1/fpm/php.ini && \
    sed -i "s/post_max_size = .*/post_max_size = 100M/" /etc/php/7.1/fpm/php.ini && \
    sed -i "s/;date.timezone.*/date.timezone = UTC/" /etc/php/7.1/fpm/php.ini

RUN /sbin/useradd php-fpm
RUN sed -i -e "s/user = .*/user = php-fpm/" /etc/php-fpm.d/www.conf && \
    sed -i -e "s/group = .*/group = php-fpm/" /etc/php-fpm.d/www.conf

RUN systemctl enable php-fpm.service

# install composer
COPY composer-installer /src/composer-installer
RUN php /src/composer-installer --install-dir=/usr/local/bin --filename=composer
RUN composer self-update

ENV MYSQL_ROOT_PASS=root
ENV	MYSQL_DATABASE=secret

# alias
RUN echo 'alias artisan="php artisan"' >> ~/.bashrc
RUN echo 'alias l="ls -la"' >> ~/.bashrc

VOLUME ["/var/log/supervisor"]
VOLUME ["/run", "/tmp", "/sys/fs/cgroup"]

WORKDIR /var/www/html/
EXPOSE 22 80 443 3306 6379 9999 27017

ENTRYPOINT ["/bin/bash","-c"]
CMD ["/usr/bin/supervisord"]