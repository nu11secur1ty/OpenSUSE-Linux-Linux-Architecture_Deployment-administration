#!/usr/bin/bash

# install Apache2
 zypper install -y apache2 
 rcapache2 start
 systemctl start apache2
 systemctl enable apache2

# Install PHP5
 zypper install -y php5 php5-mysql apache2-mod_php5 
 a2enmod php5

# Install MAriadDB
 zypper install -y mariadb mariadb-tools 
 rcmysql start
 systemctl start mysql
 systemctl enable mysql
 
 
