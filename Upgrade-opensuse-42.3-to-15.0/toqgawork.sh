#!/usr/bin/bash
# Author V.Varbanovski @nu11secur1ty

# Update old version
zypper up -y
zypper dup -y
# Remove old php5
  zypper remove -y  php5 php5-mysql apache2-mod_php5
# Install a new php7
  zypper install -y php7 php7-mysql apache2-mod_php7 
  a2enmod php7
# Compiling a php5
  zypper install -y libjpeg-devel 
  zypper install -y libxml2-devel 
  zypper install -y sqlite3 
  zypper install -y bison 
  zypper install -y gcc 
  zypper install -y gmp-devel 
  zypper install -y openssl-devel 
  zypper install -y make 
#Installing Curl
  cd /usr/src/
  wget http://curl.haxx.se/download/curl-7.37.1.tar.bz2
  tar xvf curl-7.37.1.tar.bz2
  cd curl-7.37.1/
  ./configure 
  make && make install
    sleep 1;
# Build PHP5
  cd /usr/src/
  wget https://github.com/nu11secur1ty/OpenSUSE-Linux-Linux-Architecture_Deployment-administration/raw/master/PHP/php5env/php-5.6.40.tar.gz
  tar -xvf php-5.6.40.tar.gz
  cd php-5.6.40/
  ./configure --enable-mbstring --with-curl --with-gmp --with-openssl --with-mysqli 
  make && make install
  a2enmod php5
  sleep 1;
# Make a soft link
  ln -s /usr/local/bin/php /usr/bin/php5
# Buld Python 3.7
  curl -s https://raw.githubusercontent.com/nu11secur1ty/Python-installer/master/python37installer.sh | bash
# Upgrade 
  rm /etc/zypp/repos.d/openSUSE
  sed -i 's/42.3/15.0/' /etc/zypp/repos.d/*
  zypper refresh
  zypper up -y
  zypper dup -y
  telinit 6
exit 0;
