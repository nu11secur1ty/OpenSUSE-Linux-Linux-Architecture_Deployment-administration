# Grep only one line from file:
```
sed '1!d' /etc/apache2/mods-available/dnssd.conf
```
- output:
```
# This is the config file for mod_dnssd.
```
# Grep range of lines:

```
sed -n '1,5p' /etc/apache2/mods-available/dnssd.conf 
```
- output:

```
# This is the config file for mod_dnssd.

<IfModule mod_dnssd.c>
	DNSSDEnable On
</IfModule>
```

