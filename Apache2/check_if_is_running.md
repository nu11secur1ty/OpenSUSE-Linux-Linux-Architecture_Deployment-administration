


```bash
#!/bin/bash
# Here you can put your service
service=httpd

if (( $(ps -ef | grep -v grep | grep $service | wc -l) > 0 ))
then
  echo “$service is running!!!”
else
  rcapache2 start
fi
```
