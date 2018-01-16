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
# Check for avalible memory of the machine:

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

Now the confusing thing comes out.

I will use AB (ApacheBench)  to run a test.
Simulate the situation of 500 concurrent client visit.

```
ab -n 10000 -c 500 http://0.0.0.0/index.xxxxxx
```

after run this test command in the client computer.

The server's httpd process increased to 175.

```
ps -ef | grep httpd | wc -l
175
```

# then during this ab test, run free again to monitor the memory usage:

```
             total       used       free     shared    buffers     cached
Mem:       2964056    2828572     135484          0     231684    2075648
-/+ buffers/cache:     521240    2442816
Swap:      2097144        104    2097040
```

available memory now is =2442816 / 1024 =2385MB.

idle memory usage 2605MB - busy time memory usage 2385MB = 220MB.  Apache server increased nearly 160 child processes. but the memory usage only increased only 220MB memory usage.
# According to the top command output, we know that each httpd child process will consume 10Mb memory nearly. so 160 httpd child processes will reach to 1600MB memory usage.

29416 apache    15   0 21004  10m 2996 S  0.0  0.3   0:00.41 httpd

# See number of Apache child processes

```
ps -ef | grep httpd | wc -l
```

