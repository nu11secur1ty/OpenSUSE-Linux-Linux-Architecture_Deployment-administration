# Check if your apache is not running and start him if he is not.



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
```
# Crontab's

 - At every 5th minute.
```bash 
*/5 * * * *    bash /path/to/ypur/script.sh
```
