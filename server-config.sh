#!/usr/bin/env bash

# Comment out bindIp to allow remote accesss

sed -i "s|bindIp: 127.0.0.1|#bindIp: 127.0.0.1|g" /etc/mongod.conf

sed -i "s|#ServerName www\.example\.com:80|ServerName $HOSTNAME:80|g" /etc/httpd/conf/httpd.conf

# Create symlink to customizable conf for virtual hosts

ln -s /var/www/html/virtualhosts.conf /etc/httpd/conf.d/virtualhosts.conf

# Remove speling module to mimic Servers

rm /etc/httpd/modules/mod_speling.so


# Enable networking

echo "NETWORKING=yes" > /etc/sysconfig/network


service httpd stop