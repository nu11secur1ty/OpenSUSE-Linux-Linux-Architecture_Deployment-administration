# EVASIVE DDoS securing module
![](https://github.com/nu11secur1ty/OpenSUSE-Linux-Linux-Architecture_Deployment-administration/blob/master/Apache2/mod_evasive/Apache_mode_evasive.jpg)
# For openSUSE Leap 42.3 run the following as root:
```bash
zypper addrepo https://download.opensuse.org/repositories/Apache:Modules/openSUSE_Leap_42.3/Apache:Modules.repo
zypper refresh
zypper install apache2-mod_evasive
```
- Default config is in
`vim /etc/apache2/conf.d/mod_evasive.conf`
```bash
<IfModule mod_evasive24.c>
	#
	# The hash table size defines the number of top-level nodes for each
	# child's hash table. Increasing this number will provide faster
	# performance by decreasing the number of iterations required to get to
	# the record, but consume more memory for table space. You should
	# increase this if you have a busy web server. The value you specify
	# will automatically be tiered up to the next prime number in the
	# primes list (see mod_evasive.c for a list of primes used).
	#
	DOSHashTableSize    3097

	#
	# This is the threshhold for the number of requests for the same page
	# (or URI) per page interval. Once the threshhold for that interval has
	# been exceeded, the IP address of the client will be added to the
	# blocking list.
	#
	DOSPageCount        2

	#
	# This is the threshhold for the total number of requests for any
	# object by the same client on the same listener per site interval.
	# Once the threshhold for that interval has been exceeded, the IP
	# address of the client will be added to the blocking list.
	#
	DOSSiteCount        50

	#
	# The interval for the page count threshhold; defaults to 1 second
	# intervals.
	#
	DOSPageInterval     1

	#
	# The interval for the site count threshhold; defaults to 1 second
	# intervals.
	#
	DOSSiteInterval     1

	#
	# The blocking period is the amount of time (in seconds) that a client
	# will be blocked for if they are added to the blocking list. During
	# this time, all subsequent requests from the client will result in a
	# 403 (Forbidden) and the timer being reset (e.g. another 10 seconds).
	# Since the timer is reset for every subsequent request, it is not
	# necessary to have a long blocking period; in the event of a DoS
	# attack, this timer will keep getting reset.
	#
	DOSBlockingPeriod   10

	#
	# If this value is set, an email will be sent to the address specified
	# whenever an IP address becomes blacklisted. A locking mechanism using
	# /tmp prevents continuous emails from being sent.
	#
	# NOTE: Requires /bin/mail (provided by mailx)
	#
	#DOSEmailNotify      you@yourdomain.com

	#
	# If this value is set, the system command specified will be executed
	# whenever an IP address becomes blacklisted. This is designed to
	# enable system calls to ip filter or other tools. A locking mechanism
	# using /tmp prevents continuous system calls. Use %s to denote the IP
	# address of the blacklisted IP.
	#
	#DOSSystemCommand    "su - someuser -c '/sbin/... %s ...'"

	#
	# Choose an alternative temp directory By default "/tmp" will be used
	# for locking mechanism, which opens some security issues if your
	# system is open to shell users.
	#
	#   http://security.lss.hr/index.php?page=details&ID=LSS-2005-01-01
	#
	# In the event you have nonprivileged shell users, you'll want to
	# create a directory writable only to the user Apache is running as
	# (usually root), then set this in your httpd.conf.
	#
	#DOSLogDir           "/var/lock/mod_evasive"

	#
	# You can use whitelists to disable the module for certain ranges of
	# IPs. Wildcards can be used on up to the last 3 octets if necessary.
	# Multiple DOSWhitelist commands may be used in the configuration.
	#
	#DOSWhitelist   127.0.0.1
	#DOSWhitelist   192.168.0.*
</IfModule>
```
- By default version mod_evasive24 is enabled after installation
- check if the module is enabled
```bash
apachectl -M | grep evasive
```
------------------------------------------------------------------------------------------

# Manual installation

- Compiling Mod_evasive
`Mod_evasive:`[Read](https://www.suse.com/c/protecting-apache-against-dos-attack-modevasive/?fbclid=IwAR3mt5DpmaPKhJy6owhI0gBkcJMIOr2j5abw3aC1mQ52H6KturCpIMvCFH8)

- Direct download, installing and configuring: [Link](https://github.com/nu11secur1ty/mod_evasive)

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
    #DOSSiteCount        50
    DOSSiteCount        200
    DOSPageInterval     1
    DOSSiteInterval     1
    DOSBlockingPeriod   10
</IfModule> 
```
- Manually restrict from nu11secur1ty
```baqs
<IfModule mod_evasive24.c>
   DOSHashTableSize 2048
   DOSPageCount 25  # maximum number of requests for the same page
   DOSSiteCount 300  # total number of requests for any object by the same client IP on the same listener
   DOSPageInterval 1.0 # interval for the page count threshold
   DOSSiteInterval 1.0  # interval for the site count threshold
   DOSBlockingPeriod 10.0 # time that a client IP will be blocked for
   DOSLogDir “/var/log/apache2/evasive”
   DOSEmailNotify admin@domain.com
<IfModule>
```
- From Rapid7
```bash
 <IfModule mod_evasive24.c> 
     DOSHashTableSize 3097 
     DOSPageCount 2 
     DOSSiteCount 50 
     DOSPageInterval 1 
     DOSSiteInterval 1 
     DOSBlockingPeriod 10 
     DOSEmailNotify email@yourdomain.com 
     DOSSystemCommand "su - someuser -c '/sbin/... %s ...'" 
     DOSLogDir "/var/log/mod_evasive" 
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
- Output should be
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
- You can check the logs, in
```bash
tail -f /var/log/apache2/access_log
tail -f /var/log/apache2/error_log
```
- More: [Link](https://www.suse.com/c/protecting-apache-against-dos-attack-modevasive/)
- Rapid7: [Link](https://blog.rapid7.com/2017/04/09/how-to-configure-modevasive-with-apache-on-ubuntu-linux/?fbclid=IwAR1ru-5SePUZX4NUl1aGv1ZUTEaTd1T7Pqw_2qDWV_8IlfCJjYZI-LXr3kg)

# Uninstalling
```bash
zypper remove apache2-mod_evasive
mv /etc/apache2/mod_evasive.conf /etc/apache2/mod_evasive.conf.back
a2dismod evasive24_module
```
- to be sure
```bash
cd /etc/apache2/
rm mod_evasive.conf
```
- Restart Apache2
```bash
rcapache2 restart
```
