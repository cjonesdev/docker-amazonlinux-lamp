FROM amazonlinux:latest
LABEL maintainer="caseyjonesdev@gmail.com"

COPY systemctl.py /tmp/systemctl.py
COPY create-user.sh /tmp/create-user.sh
COPY server-config.sh /tmp/server-config.sh
COPY start-servers.sh /usr/sbin/start-servers
COPY mongodb-org-4.4.repo /etc/yum.repos.d/mongodb-org-4.4.repo
COPY db-setup.sh /tmp/db-setup.sh
COPY install-php-mongo-library.sh /tmp/install-php-mongo-library.sh

RUN yum update -y && yum install -y \
sudo \
make \
httpd \
gcc \
php-pear \
nano \
man \
tar \
openssl-devel \
&& amazon-linux-extras install -y \
php7.3

RUN yum install -y \
php-bcmath \
php-dba \
php-dbg \
php-devel \
php-embedded \
php-enchant \
php-gd \
php-gmp \
php-intl \
php-ldap \
php-mbstring \
php-odbc \
php-opcache \
php-pecl-mcrypt \
php-pecl-memcached \
php-pecl-oauth \
php-pecl-redis \
php-pecl-uuid \
php-pecl-zip \
php-pgsql \
php-pspell \
php-recode \
php-snmp \
php-soap \
php-xmlrpc \
mongodb-org && \
yum install -y https://dev.mysql.com/get/mysql57-community-release-el7-11.noarch.rpm && \
yum update -y && yum install -y \
mysql-community-client \
mysql-community-server \
&& yum clean all && rm -rf /var/cache/yum

RUN mv /tmp/systemctl.py /usr/bin/systemctl && \
chmod 755 /usr/bin/systemctl && \
/bin/bash /tmp/create-user.sh && \
rm /tmp/create-user.sh && \
/bin/bash /tmp/server-config.sh && \
rm /tmp/server-config.sh && \
/bin/bash /tmp/db-setup.sh && \
rm /tmp/db-setup.sh && \
/bin/bash /tmp/install-php-mongo-library.sh && \
rm /tmp/install-php-mongo-library.sh

EXPOSE 80
EXPOSE 3306
EXPOSE 27017

CMD /usr/bin/env bash start-servers;sleep infinity
