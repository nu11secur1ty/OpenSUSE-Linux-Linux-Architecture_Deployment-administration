# Find users activity
```
$ ps -au 
- or
$ w
```
# admin:~ # ps -au
```
USER       PID    %CPU %MEM      VSZ   RSS TTY      STAT START   TIME COMMAND
user       1764   0.0  0.0      4744  1704 tty1     Ss+  Nov10   0:00 /sbin/agetty --noclear tty1 linux
user       2019   0.0  0.0     15284  5260 pts/2    Ss   Dec11   0:00 -bash
user       2066   0.0  0.0      5796  1380 pts/2    S+   Dec11   0:00 tail -f error_log
user       11340  0.0  0.0     15180  5160 pts/1    Ss   11:59   0:00 -bash
user       11370  0.0  0.0     30232  7064 pts/1    S+   11:59   0:00 mysql -p
user       12149  0.0  0.0     15324  5336 pts/3    Ss   13:14   0:00 -bash
user       12255  0.0  0.0     36852  3516 pts/3    R+   13:23   0:00 ps -au
user       63590  0.0  0.0     15324  5392 pts/0    Ss+  Dec11   0:00 -bash
```


# Search for pts/0 x.x.x.x Pid id
```
ps -ft pts/6 -t pts/9 -t pts/10
```
# This would produce an output similar to:
```
UID        PID  PPID  C STIME TTY          TIME CMD
user       772  2701  0 15:26 pts/6    00:00:00 bash
user       773  2701  0 16:26 pts/9    00:00:00 bash
user       774  2701  0 17:26 pts/10   00:00:00 bash
```
# Grab the PID from the result.
- Use the PIDs to kill the processes:
```
kill <PID1> <PID2> <PID3> ...
```
# For the above example:
```
kill 772 773 774
```
# If the process doesn't gracefully terminate, just as a last option you can forcefully kill by sending a SIGKILL
```
kill -9 <PID>
```
