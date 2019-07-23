#!/usr/bin/bash

# install Apache2
zypper in -n apache2
systemctl start apache2
systemctl enable apache2

# Install PHP5
 zypper in -n php5 php5-mysql apache2-mod_php5
 a2enmod php5
 
 # Install MAriadDB
 zypper in -n mariadb mariadb-tools
 systemctl start mysql
 systemctl enable mysql
 
 
