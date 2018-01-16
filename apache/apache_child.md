# How Apache child processes consumming memory


```
uname -a
Linux admin 4.4.104-39-default #1 SMP Thu Jan 4 08:11:03 UTC 2018 (7db1912) x86_64 x86_64 x86_64 GNU/Linux
```
# Check for apache pid
```
rcapache2 status
```
- output:
```
● apache2.service - The Apache Webserver
   Loaded: loaded (/usr/lib/systemd/system/apache2.service; disabled; vendor preset: disabled)
   Active: active (running) since Tue 2018-01-16 08:03:15 EET; 46min ago
 Main PID: 98099 (httpd-prefork)
   Status: "Total requests: 0; Current requests/sec: 0; Current traffic:   0 B/sec"
    Tasks: 11

```
# Check for using memory using top:
```
top -p 98099
```
- output:

```
top - 08:53:39 up 3 days, 39 min,  1 user,  load average: 0.16, 0.16, 0.09
Tasks:   1 total,   0 running,   1 sleeping,   0 stopped,   0 zombie
%Cpu(s):  1.7 us,  0.5 sy,  0.2 ni, 97.7 id,  0.0 wa,  0.0 hi,  0.0 si,  0.0 st
KiB Mem:   4021584 total,  3755908 used,   265676 free,   203640 buffers
KiB Swap:  4718588 total,        0 used,  4718588 free.  2404844 cached Mem

   PID USER      PR  NI    VIRT    RES    SHR S  %CPU  %MEM     TIME+ COMMAND                                                                                                                 
 98099 root      20   0  108644   8560   6856 S 0.000 0.213   0:00.39 httpd-prefork
```
# Check for available memory of the machine:

```
free -m
```
- output:

```
             total       used       free     shared    buffers     cached
Mem:          3927       3594        333         25        198       2348
-/+ buffers/cache:       1046       2880
Swap:         4607          0       4607

```
# so we can get idle time for available memory 

```
ab -n 10000 -c 500 localhost/index.html
```
- output:
```
This is ApacheBench, Version 2.3 <$Revision: 1748469 $>
Copyright 1996 Adam Twiss, Zeus Technology Ltd, http://www.zeustech.net/
Licensed to The Apache Software Foundation, http://www.apache.org/

Benchmarking localhost (be patient)
Completed 1000 requests
Completed 2000 requests
Completed 3000 requests
Completed 4000 requests
Completed 5000 requests
Completed 6000 requests
Completed 7000 requests
Completed 8000 requests
Completed 9000 requests
Completed 10000 requests
Finished 10000 requests


Server Software:        Apache
Server Hostname:        localhost
Server Port:            80

Document Path:          /index.html
Document Length:        45 bytes

Concurrency Level:      500
Time taken for tests:   0.992 seconds
Complete requests:      10000
Failed requests:        0
Total transferred:      2750000 bytes
HTML transferred:       450000 bytes
Requests per second:    10081.73 [#/sec] (mean)
Time per request:       49.595 [ms] (mean)
Time per request:       0.099 [ms] (mean, across all concurrent requests)
Transfer rate:          2707.50 [Kbytes/sec] received

Connection Times (ms)
              min  mean[+/-sd] median   max
Connect:        0    1   1.2      0       8
Processing:     2   21  95.7     10     921
Waiting:        1   21  95.7      9     920
Total:          7   22  96.5     10     928

Percentage of the requests served within a certain time (ms)
  50%     10
  66%     11
  75%     12
  80%     13
  90%     14
  95%     16
  98%     19
  99%    920
 100%    928 (longest request)
after run this test command in the client computer.

The server's httpd process increased to 175.

```
# Check the number of processes:

```
ps -ef | grep httpd | wc -l
12
```

# then during this ab test, run free again to monitor the memory usage:

```
             total       used       free     shared    buffers     cached
Mem:          3927       3594        332         26        198       2350
-/+ buffers/cache:       1045       2881
Swap:         4607          0       4607
```
# Optimize apache
- MaxKeepAliveRequests

```
echo -e "MaxKeepAliveRequests 500" >> /etc/apache2/httpd.conf
```

- KeepAliveTimeout
```
echo -e "KeepAliveTimeout 5" >> /etc/apache2/httpd.conf 
```

- KeepAlive
```
echo -e "KeepAlive On" >> /etc/apache2/httpd.conf
```
# Configure MPM Prefork
- check if module is loaded
```
httpd -M | grep mpm
- or
apachectl -t -D DUMP_MODULES

```
- output 
```
mpm_prefork_module (static)
```
# Make Apache performance better using the Apache MPM

```
admin:~ # cat <<EOT>> /etc/apache2/httpd.conf 
> KeepAlive Off
> <IfModule prefork.c>
>    StartServers        5
>    MinSpareServers     5
>    MaxSpareServers     10
>    MaxClients          150
>    MaxRequestsPerChild 3000
> </IfModule>
> EOT
admin:~ # 
```
# Now you have to restart apache server:

```
rcapache2 restart
```

