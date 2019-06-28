# Installing php5 & php7 thogeder on OpenSuse.
- Install php5
```bash
zypper in php5
```
- Installin php7

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



