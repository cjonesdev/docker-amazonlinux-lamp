#!/usr/bin/env bash

pecl7 install mongodb

echo "extension=mongodb.so" >> '/etc/php-7.0.d/50-mongod.ini'
echo "extension=mongodb.so" >> '/etc/php-fpm-7.0.d/50-mongod.ini'
echo "extension=mongodb.so" >> '/etc/php-zts-7.0.d/50-mongod.ini'
