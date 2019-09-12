zypper in squid
systemctl start squid
systemctl enable squid

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
