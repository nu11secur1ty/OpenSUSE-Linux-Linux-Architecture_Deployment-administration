# How Apache child processes consumming memory


```
uname -a
2.6.18-164.el5 #1 SMP Tue Aug 18 15:51:54 EDT 2009 i686 i686 i386 GNU/Linux

During the idle time. run the top command. as below, you can see one httpd process will use nearly 10M RAM.

PID USER      PR  NI  VIRT  RES  SHR S %CPU %MEM    TIME+  COMMAND
13775 mysql     15   0  340m  53m 3980 S  0.0  1.8   0:44.82 mysqld
15377 root      15   0 20204  10m 4684 S  0.0  0.4   0:00.58 httpd
2798 root      34  19 26320  10m 2148 S  0.0  0.4   0:00.95 yum-updatesd
29868 apache    15   0 21020  10m 3024 S  0.0  0.3   0:00.12 httpd
29416 apache    15   0 21004  10m 2996 S  0.0  0.3   0:00.41 httpd
29439 apache    15   0 21004  10m 2996 S  0.0  0.3   0:00.37 httpd
29457 apache    15   0 21004  10m 2996 S  0.0  0.3   0:00.47 httpd
29530 apache    15   0 21004  10m 2996 S  0.0  0.3   0:00.44 httpd
29546 apache    15   0 21004  10m 2996 S  0.0  0.3   0:00.40 httpd
29592 apache    15   0 21004  10m 2996 S  0.0  0.3   0:00.36 httpd
29472 apache    15   0 21004  10m 2992 S  0.0  0.3   0:00.34 httpd
29562 apache    15   0 21004  10m 2992 S  0.0  0.3   0:00.31 httpd
29881 apache    15   0 21008  10m 2992 S  0.0  0.3   0:00.08 httpd
```
# Also use free command to monitor the memory usage status:

```
             total       used       free     shared    buffers     cached
Mem:       2964056    2602636     361420          0     231664    2074572
-/+ buffers/cache:     296400    2667656
Swap:      2097144        104    2097040
```
# so we can get idle time, available memory will be 2667656.  / 1024= 2605MB.

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

