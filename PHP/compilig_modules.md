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
./configure --enable-mbstring --with-curl --with-openssl --with-gmp
```

# Building
```bash
make
make test
make install
```
# Good luck ;)
