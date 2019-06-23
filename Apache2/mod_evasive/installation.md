# EVASIVE DDoS securing module
![](https://github.com/nu11secur1ty/OpenSUSE-Linux-Linux-Architecture_Deployment-administration/blob/master/Apache2/mod_evasive/Apache_mode_evasive.jpg)
# For openSUSE Leap 42.3 run the following as root:
```bash
zypper addrepo https://download.opensuse.org/repositories/Apache:Modules/openSUSE_Leap_42.3/Apache:Modules.repo
zypper refresh
zypper install apache2-mod_evasive
```
# Manual installation

- Compiling Mod_evasive
`Mod_evasive:`[Read](https://www.suse.com/c/protecting-apache-against-dos-attack-modevasive/?fbclid=IwAR3mt5DpmaPKhJy6owhI0gBkcJMIOr2j5abw3aC1mQ52H6KturCpIMvCFH8)

- Direct download:[Link](https://github.com/nu11secur1ty/mod_evasive/blob/master/README)

Once you have compiled the mod_evasive module you will need the module to load when Apache is started or restarted. The file that needs to be modified is “/etc/sysconfig/apache2” and the directive that needs to be altered is “APACHE_MODULES=” as it needs to include the mod_evasive24 module.
```bash
APACHE_MODULES="   (mod_evasive24)   actions alias auth_basic authn_file authz_host authz_groupfile authz_default authz_user authn_dbm autoindex cgi dir env expires include log_config mime negotiation setenvif ssl suexec userdir php5"
```
# Beginning
- Check version
```bash
apachectl -M | grep evasive
```
- in my case the output is 

`evasive24_module (shared)`

- Enabling

```bash
a2enmod evasive24_module
```
 - or
```bash
a2enmod mod_evasive24
```
# Mod_evasive configuration
Once you have modified the “/etc/sysconfig/apache2” configuration file you will need to create a configuration file for the mod_evasive module. In the “/etc/apache2” directory you will need to create a file called: “mod_evasive.conf” with the following or similar content.

```bash 
<IfModule mod_evasive24.c>
    DOSHashTableSize    3097
    DOSPageCount        2
    DOSSiteCount        50
    DOSPageInterval     1
    DOSSiteInterval     1
    DOSBlockingPeriod   10
</IfModule> 
```
- Test Apache2 config
```bash
apachectl -t
```
- Output must be
```bash
Syntax OK
```
- Restart Apache2
```bash 
rcapache2 restart
```
- Test evasive module
```bash
perl /usr/share/doc/packages/apache2-mod_evasive/test.pl
```
- Output should
```html
<p>You don't have permission to access / on this server.</p>
<h1>Forbidden</h1>
<p>You don't have permission to access / on this server.</p>
<h1>Forbidden</h1>
<p>You don't have permission to access / on this server.</p>
<h1>Forbidden</h1>
<p>You don't have permission to access / on this server.</p>
<h1>Forbidden</h1>
<p>You don't have permission to access / on this server.</p>
<h1>Forbidden</h1>
<p>You don't have permission to access / on this server.</p>
<h1>Forbidden</h1>
<p>You don't have permission to access / on this server.</p>
<h1>Forbidden</h1>
<p>You don't have permission to access / on this server.</p>
```
- if you have another securing method "POST" "GET" "HTTP" "HTTPS" "REQUESTS" ;)

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
- More: [Link](https://www.suse.com/c/protecting-apache-against-dos-attack-modevasive/)
- Rapid7: [Link](https://blog.rapid7.com/2017/04/09/how-to-configure-modevasive-with-apache-on-ubuntu-linux/?fbclid=IwAR1ru-5SePUZX4NUl1aGv1ZUTEaTd1T7Pqw_2qDWV_8IlfCJjYZI-LXr3kg)



