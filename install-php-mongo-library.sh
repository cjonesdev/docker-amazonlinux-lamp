#!/usr/bin/env bash

# update pecl
pecl channel-update pecl.php.net

pecl install mongodb

echo "extension=mongodb.so" > /etc/php.d/30-mongo.ini
