# 1. Get the running processes of logged-in user using w

w command is used to show logged-in user names and what they are doing. The information will be read from /var/run/utmp file. The output of the w command contains the following columns:

    Name of the user
    User’s machine number or tty number
    Remote machine address
    User’s Login time
    Idle time (not usable time)
    Time used by all processes attached to the tty (JCPU time)
    Time used by the current process (PCPU time)
    Command currently getting executed by the users

 
Following options can be used for the w command:

    -h Ignore the header information
    -u Display the load average (uptime output)
    -s Remove the JCPU, PCPU, and login time.
```
$ w
 23:04:27 up 29 days,  7:51,  3 users,  load average: 0.04, 0.06, 0.02
USER     TTY      FROM              LOGIN@   IDLE   JCPU   PCPU WHAT
ramesh   pts/0    dev-db-server        22:57    8.00s  0.05s  0.01s sshd: ramesh [priv]
jason    pts/1    dev-db-server        23:01    2:53   0.01s  0.01s -bash
john     pts/2    dev-db-server        23:04    0.00s  0.00s  0.00s w

$ w -h
ramesh   pts/0    dev-db-server        22:57   17:43   2.52s  0.01s sshd: ramesh [priv]
jason    pts/1    dev-db-server        23:01   20:28   0.01s  0.01s -bash
john     pts/2    dev-db-server        23:04    0.00s  0.03s  0.00s w -h

$ w -u
 23:22:06 up 29 days,  8:08,  3 users,  load average: 0.00, 0.00, 0.00
USER     TTY      FROM              LOGIN@   IDLE   JCPU   PCPU WHAT
ramesh   pts/0    dev-db-server        22:57   17:47   2.52s  2.49s top
jason    pts/1    dev-db-server        23:01   20:32   0.01s  0.01s -bash
john     pts/2    dev-db-server        23:04    0.00s  0.03s  0.00s w -u

$ w -s
 23:22:10 up 29 days,  8:08,  3 users,  load average: 0.00, 0.00, 0.00
USER     TTY      FROM               IDLE WHAT
ramesh   pts/0    dev-db-server        17:51  sshd: ramesh [priv]
jason    pts/1    dev-db-server        20:36  -bash
john     pts/2    dev-db-server         1.00s w -s
```
# 2. Get the user name and process of logged in user using who and users command

who command is used to get the list of the usernames who are currently logged in. Output of the who command contains the following columns: user name, tty number, date and time, machine address.


```
$ who
ramesh pts/0        2009-03-28 22:57 (dev-db-server)
jason  pts/1        2009-03-28 23:01 (dev-db-server)
john   pts/2        2009-03-28 23:04 (dev-db-server)
```

# To get a list of all usernames that are currently logged in, use the following:


```
$ who | cut -d' ' -f1 | sort | uniq
user1
user2
user3
```

