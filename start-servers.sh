#!/usr/bin/env bash

service httpd stop
service mysqld stop
service mongod stop

if [ -e /var/run/httpd/httpd.pid ]
then
	rm -f /var/run/httpd/httpd.pid
fi

if [ -e /var/run/mysqld/mysqld.pid ]
then
	rm -f /var/run/mysqld/mysqld.pid
fi

if [ -e /var/lib/mysql/mysql.sock ]
then
	rm -f /var/lib/mysql/mysql.sock
fi

if [ -e /var/run/mongod/mongod.pid ]
then
	rm -f /var/run/mongod/mongod.pid
fi

rm -f /var/run/httpd/*
rm -f /tmp/*

service httpd start
service mysqld start
service mongod start
service php-fpm start
