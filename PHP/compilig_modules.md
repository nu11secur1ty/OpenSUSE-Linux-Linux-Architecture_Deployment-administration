# Example modules:
```xml
curl 
gmp 
mbstring
openssl 
```

# Checking for your existing modules
```bash
php -m
php-cgi -m
```

# Compilig a modules
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

# Building
```bash
./configure
make
make test
make install
```
# Good luck ;)
