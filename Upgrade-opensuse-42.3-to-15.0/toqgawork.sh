#!/usr/bin/bash
# Author V.Varbanovski @nu11secur1ty
# Update old version
zypper up -y
zypper dup -y

# Remove old php5
zypper remove php5

# Install a new php7
zypper in php7 php7-mysql apache2-mod_php7 -y
a2enmod php7

# Compiling a php5
  zypper in libjpeg-devel -y
  zypper in libxml2-devel -y
  zypper in sqlite3 -y
  zypper in bison -y
  zypper in gcc -y
  zypper in gmp-devel -y
  zypper in openssl-devel -y
  zypper in make -y

#Installing Curl
cd /usr/src/
wget http://curl.haxx.se/download/curl-7.37.1.tar.bz2
tar xvf curl-7.37.1.tar.bz2
cd curl-7.37.1/
  ./configure && make && make install
    
# Build
cd /usr/src/
wget https://github.com/nu11secur1ty/OpenSUSE-Linux-Linux-Architecture_Deployment-administration/raw/master/PHP/php5env/php-5.6.40.tar.gz
tar -xvf php-5.6.40.tar.gz
cd php-5.6.40/
./configure --enable-mbstring --with-curl --with-gmp --with-openssl --with-mysqli && make && make install

# Make a soft link
ln -s /usr/local/bin/php /usr/bin/php5

# Buld Python 3.7
curl -s https://raw.githubusercontent.com/nu11secur1ty/Python-installer/master/python37installer.sh | bash

# Upgrade 
  sleep 3;
sed -i 's/42.3/15.0/' /etc/zypp/repos.d/*
  zypper refresh
  zypper dup --download-in-advance 
  telinit 6
exit 0;
