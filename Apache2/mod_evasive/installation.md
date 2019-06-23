# For openSUSE Leap 42.3 run the following as root:
```bash
zypper addrepo https://download.opensuse.org/repositories/Apache:Modules/openSUSE_Leap_42.3/Apache:Modules.repo
zypper refresh
zypper install apache2-mod_evasive
```
# Enable
Once you have compiled the mod_evasive module you will need the module to load when Apache is started or restarted. The file that needs to be modified is “/etc/sysconfig/apache2” and the directive that needs to be altered is “APACHE_MODULES=” as it needs to include the mod_evasive20 module, as shown in Figure 2.
```bash
APACHE_MODULES="   (mod_evasive20)   actions alias auth_basic authn_file authz_host authz_groupfile authz_default authz_user authn_dbm autoindex cgi dir env expires include log_config mime negotiation setenvif ssl suexec userdir php5"
```
# Manual 
- Check version
```bash
apachectl -M | grep evasive
```
- Enabling

```bash
a2enmod mod_evasivexx
```
# Mod_evasive configuration
Once you have modified the “/etc/sysconfig/apache2” configuration file you will need to create a configuration file for the mod_evasive module. In the “/etc/apache2” directory you will need to create a file called: “mod_evasive.conf” with the following or similar content.

```bash 
<IfModule mod_evasive20.c>
    DOSHashTableSize    3097
    DOSPageCount        2
    DOSSiteCount        50
    DOSPageInterval     1
    DOSSiteInterval     1
    DOSBlockingPeriod   10
</IfModule> 
```
- Test
```bash
perl /usr/share/doc/packages/apache2-mod_evasive/test.pl
```
- Output should
```xml
HTTP/1.1 400 Bad Request
HTTP/1.1 400 Bad Request
HTTP/1.1 400 Bad Request
HTTP/1.1 400 Bad Request
HTTP/1.1 400 Bad Request
HTTP/1.1 400 Bad Request
HTTP/1.1 400 Bad Request
HTTP/1.1 400 Bad Request
HTTP/1.1 400 Bad Request
HTTP/1.1 400 Bad Request
HTTP/1.1 400 Bad Request
HTTP/1.1 400 Bad Request
HTTP/1.1 400 Bad Request
HTTP/1.1 400 Bad Request
HTTP/1.1 400 Bad Request
HTTP/1.1 400 Bad Request
HTTP/1.1 400 Bad Request
HTTP/1.1 400 Bad Request
HTTP/1.1 400 Bad Request
HTTP/1.1 400 Bad Request
HTTP/1.1 400 Bad Request
HTTP/1.1 400 Bad Request
HTTP/1.1 400 Bad Request
HTTP/1.1 400 Bad Request
HTTP/1.1 400 Bad Request
HTTP/1.1 400 Bad Request
HTTP/1.1 400 Bad Request
HTTP/1.1 400 Bad Request
HTTP/1.1 400 Bad Request
HTTP/1.1 400 Bad Request
HTTP/1.1 400 Bad Request
HTTP/1.1 400 Bad Request
HTTP/1.1 400 Bad Request
HTTP/1.1 400 Bad Request
HTTP/1.1 400 Bad Request
HTTP/1.1 400 Bad Request
HTTP/1.1 400 Bad Request
HTTP/1.1 400 Bad Request
HTTP/1.1 400 Bad Request
HTTP/1.1 400 Bad Request
HTTP/1.1 400 Bad Request
HTTP/1.1 400 Bad Request
HTTP/1.1 400 Bad Request
HTTP/1.1 400 Bad Request
HTTP/1.1 400 Bad Request
HTTP/1.1 400 Bad Request
HTTP/1.1 400 Bad Request
HTTP/1.1 400 Bad Request
HTTP/1.1 400 Bad Request
HTTP/1.1 400 Bad Request
HTTP/1.1 400 Bad Request
HTTP/1.1 400 Bad Request
HTTP/1.1 400 Bad Request
HTTP/1.1 400 Bad Request
HTTP/1.1 400 Bad Request
HTTP/1.1 400 Bad Request
HTTP/1.1 400 Bad Request
HTTP/1.1 400 Bad Request
HTTP/1.1 400 Bad Request
HTTP/1.1 400 Bad Request
HTTP/1.1 400 Bad Request
HTTP/1.1 400 Bad Request
HTTP/1.1 400 Bad Request
HTTP/1.1 400 Bad Request
HTTP/1.1 400 Bad Request
HTTP/1.1 400 Bad Request
HTTP/1.1 400 Bad Request
HTTP/1.1 400 Bad Request
HTTP/1.1 400 Bad Request
HTTP/1.1 400 Bad Request
HTTP/1.1 400 Bad Request
HTTP/1.1 400 Bad Request
HTTP/1.1 400 Bad Request
HTTP/1.1 400 Bad Request
HTTP/1.1 400 Bad Request
HTTP/1.1 400 Bad Request
HTTP/1.1 400 Bad Request
HTTP/1.1 400 Bad Request
HTTP/1.1 400 Bad Request
HTTP/1.1 400 Bad Request
HTTP/1.1 400 Bad Request
HTTP/1.1 400 Bad Request
HTTP/1.1 400 Bad Request
```
- or 
```xml
 HTTP/1.1 403 Forbidden 
 HTTP/1.1 403 Forbidden 
 HTTP/1.1 403 Forbidden 
 HTTP/1.1 403 Forbidden 
 HTTP/1.1 403 Forbidden 
 HTTP/1.1 403 Forbidden 
 HTTP/1.1 403 Forbidden 
 HTTP/1.1 403 Forbidden 
 HTTP/1.1 403 Forbidden 
 HTTP/1.1 403 Forbidden 
 HTTP/1.1 403 Forbidden 
 HTTP/1.1 403 Forbidden 
 HTTP/1.1 403 Forbidden
```




