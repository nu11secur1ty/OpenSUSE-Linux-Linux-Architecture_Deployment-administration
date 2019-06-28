# Check if your apache is running, and start him if he is not working.

`Before to do this script you must know how you configure your apache2 web server.
If something is wrong on your configuration or something is missing again in your configuration, your apache will never run!
This script is for when you are already done with your Apache2 server and tested it`

- Test your configuration:
```bash 
:~# apachectl -t
```
- If something is not ok, the server will report you with a message on your console.
  Then you must fix your problems and then you can use this checking script.
  
# WARNINGS: 
- You must be known exactly what you doing with your web server and when you do this before you use this script!!!
- If you have an application which may make changes of your apache configuration, you have to complete with that before you take a decision to use this script!!!

```bash
#!/bin/bash
# by V.Varbanovski @nu11secur1ty

# The script needs to know, what dirs Apache2 is using
PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin

# Here you can put your service
service=httpd

if (( $(ps -ef | grep -v grep | grep $service | wc -l) > 0 ))
then
  echo “$service is running!!!”
else
  rcapache2 start
fi
  apachectl -t
exit 0;
```
# Crontab's

 - Checking at every 5th minute.
```bash 
*/5 * * * *    bash /path/to/ypur/script.sh
```
