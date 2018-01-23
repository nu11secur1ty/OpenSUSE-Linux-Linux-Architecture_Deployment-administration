# Grep only one line from file:
```
sed '1!d' /etc/apache2/mods-available/dnssd.conf
```
- output: onli first line
```
# This is the config file for mod_dnssd.
```
# Grep range of lines from file:

```
sed -n '1,5p' /etc/apache2/mods-available/dnssd.conf 
```
- output: from one to five

```
# This is the config file for mod_dnssd.

<IfModule mod_dnssd.c>
	DNSSDEnable On
</IfModule>
```


