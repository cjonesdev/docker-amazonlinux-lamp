#!/usr/bin/env bash

service mysqld start

echo "validate_password_policy=0" >> /etc/my.cnf
echo "validate_password_length=4" >> /etc/my.cnf
echo "validate_password_mixed_case_count=0" >> /etc/my.cnf
echo "validate_password_number_count=0" >> /etc/my.cnf
echo "default_password_lifetime=0" >> /etc/my.cnf
echo "validate_password_special_char_count=0" >> /etc/my.cnf
echo "sql-mode=NO_ENGINE_SUBSTITUTION" >> /etc/my.cnf

service mysqld restart

# Get MySQL temporary password

export MYSQL_PWD=`cat /var/log/mysqld.log | grep "A temporary password is generated for" | awk '{print $NF}'`
echo "Temporary Password: $MYSQL_PWD\n"

# Permanent MySQL password

NEW_PWD="root"

# Set password to root

mysql -u root --connect-expired-password -e "ALTER USER 'root'@'localhost' IDENTIFIED BY '$NEW_PWD';"
echo "ALTER USER 'root'@'localhost' IDENTIFIED BY '$NEW_PWD';"

export MYSQL_PWD=$NEW_PWD

mysql -u root -e "FLUSH PRIVILEGES;"

mysql -u root -e "GRANT ALL PRIVILEGES ON *.* TO 'root'@'localhost' WITH GRANT OPTION;"
mysql -u root -e "CREATE USER 'root'@'%' IDENTIFIED BY '$NEW_PWD';"
mysql -u root -e "GRANT ALL PRIVILEGES ON *.* TO 'root'@'%' WITH GRANT OPTION;"

# Stop MySQL to prevent socket issues on next start

service mysqld stop

