# Check if your apache is running, and start him if he is not working.



```bash
#!/bin/bash
# by V.Varbanovski @nu11secur1ty
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
