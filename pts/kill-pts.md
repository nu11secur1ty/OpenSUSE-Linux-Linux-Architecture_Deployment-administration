# Search for pts/0 x.x.x.x Pid id
ps -ft pts/6 -t pts/9 -t pts/10

This would produce an output similar to:

UID        PID  PPID  C STIME TTY          TIME CMD
user       772  2701  0 15:26 pts/6    00:00:00 bash
user       773  2701  0 16:26 pts/9    00:00:00 bash
user       774  2701  0 17:26 pts/10   00:00:00 bash

Grab the PID from the result.

Use the PIDs to kill the processes:

kill <PID1> <PID2> <PID3> ...

For the above example:

kill 772 773 774

If the process doesn't gracefully terminate, just as a last option you can forcefully kill by sending a SIGKILL

kill -9 <PID>
