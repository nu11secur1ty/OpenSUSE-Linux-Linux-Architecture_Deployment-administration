# Installing php5 & php7 thogeder on OpenSuse.
- Install php5
--------------------------------------------------
```bash
zypper in php5
```

- Installin php7
--------------------------------------------------
```bash
zypper install libjpeg-devel
zypper install libxml2-devel
bash

# Curl
```bash
wget http://curl.haxx.se/download/curl-7.37.1.tar.bz2
```
-----------------------------------------------------

- Building
```bash
./configure
make
make test # if you want to test php7 before installing 
make install
```


# Check
```bash
linuxprog@linuxprog:~> php -v
PHP 5.5.14 (cli) 
Copyright (c) 1997-2014 The PHP Group
Zend Engine v2.5.0, Copyright (c) 1998-2014 Zend Technologies

linuxprog@linuxprog:~> php-cgi -v
PHP 7.3.6 (cgi-fcgi) (built: Jun 27 2019 12:16:46)
Copyright (c) 1997-2018 The PHP Group
Zend Engine v3.3.6, Copyright (c) 1998-2018 Zend Technologies
linuxprog@linuxprog:~> 
```
- The place
```bash
linuxprog@linuxprog:~> whereis php
php: /usr/bin/php /usr/local/bin/php /usr/local/php /usr/share/man/man1/php.1.gz /usr/src/php-7.3.6/php7.spec /usr/src/php-7.3.6/php.ini-development /usr/src/php-7.3.6/php.ini-production /usr/src/php-7.3.6/php.gif
```
**NOTE:** *You can make a soft of* ***php7 - php-cgi*** *link if you want and if you know what actually happens :)*







