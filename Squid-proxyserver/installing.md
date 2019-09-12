# Installing
```bash
zypper in squid
systemctl start squid
systemctl enable squid
```
- Create restrict domains list
```bash
vim /etc/squid/blocked_sites.acl
``` 
 add
```bash
www.facebook.com
www.pornhub.com
www.twitter.com
http://www.twitter.com
https://www.twitter.com
twitter.com
```
Add sites in black list:
```bash
vim /etc/squid/blocked_sites.acl
```
add:
```bash
www.facebook.com
https://twitter.com/
twitter.com
http://twitter.com/
http://www.twitter.com/
abv.bg
```
Add your rule
```bash
vim /etc/squid/squid.conf
```
 add:
```bash
#
# INSERT YOUR OWN RULE(S) HERE TO ALLOW ACCESS FROM YOUR CLIENTS
#
#######################################################
acl local_net src 192.168.1.30
### Sites
acl restricted_sites url_regex -i "/etc/squid/blocked_sites.acl"
http_access deny restricted_sites
http_access allow local_net
http_access allow all

#######################################################
```
# If you do not know how to use in `outside network` please write to me on my email!
- BR 
