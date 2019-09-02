# Example modules:
```xml
curl 
gmp  
mbstring  
openssl  
mysql  
```

# Checking for your existing modules
```bash
php -m
php-cgi -m
```


# Installin php7 dependency packages
```bash
zypper in libjpeg-devel
zypper in libxml2-devel
zypper in sqlite3
zypper in bison3 # If you need you must compiling the bison 3
zypper in bison
zypper in gcc
zypper in gmp-devel
zypper in openssl-devel
zypper in make
```


# Building
```bash
cd /usr/src/
wget https://github.com/nu11secur1ty/OpenSUSE-Linux-Linux-Architecture_Deployment-administration/raw/master/PHP/php5env/php-5.6.40.tar.gz
tar -xvf php-5.6.40.tar.gz
cd php-5.6.40/
./configure
./configure --enable-mbstring --with-curl --with-gmp --with-openssl --with-mysqli #In my case
make
make test # if you want to test php5 before installing 
make install
```
# Compiling a single module

```bash
cd /usr/src/your_php_env/
./configure --with-your_module
```
- or
```bash
./configure --enable-your_module
```
- Example:
```bash
./configure --enable-mbstring --with-curl 
```
-------------------------------------------------------------
# For gmp
```bash
download gmp.h
```
- puth the file in:
```bash
/usr/include/gmp.h 
```
- packages:
```bash
rpm -q gmp gmp-devel
zypper in gmp-devel
```
- Building
```bash
./configure --with-gmp --with-curl --enable-mbstring
make
make install
```

# Building
```bash
./configure
make
make test
make install
```
# Good luck ;)
