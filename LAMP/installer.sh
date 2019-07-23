#!/usr/bin/bash

# install Apache2
 zypper in apache2 -y
 systemctl start apache2
 systemctl enable apache2

# Install PHP5
 zypper in php5 php5-mysql apache2-mod_php5 -y
 a2enmod php5

# Install MAriadDB
 zypper in -n mariadb mariadb-tools -y
 systemctl start mysql
 systemctl enable mysql
 
 
