# Keep rsync From Using All Your Bandwidth

If you use the rsync utility to keep your backups synchronized from your database server over to your backup or secondary file server, you might want to prevent the script from using too much bandwidth. Here’s how.

The point of limiting bandwidth is to make sure your backup scripts don’t clog up the network connection between your web server and database server. Naturally, limiting the amount of bandwidth your backups are using is going to make them happen more slowly, but if you can deal with that, this is the way to do it.

Normally your rsync command will look something like this:
```
rsync -a /backup/folder user@host:/remote/backup/folder/
```
What you’ll want to do is use the --bwlimit parameter with a KB/second value, like this:

```
rsync --bwlimit=<kb/second> <source> <dest>
```
So if you wanted to limit transfer to around 5MB per second, you could use a command like this:

```
rsync --bwlimit=5000 /backup/folder user@host:/remote/backup/folder/
```
You’ll want to make sure to calculate the size of your backups, and figure out how long it’ll take to transfer them at a slower rate – it wouldn’t be very helpful if your backup script takes 12 hours to run, for example.

You can also use the ionice command to limit the amount of bandwidth your script uses, which will help keep your scripts from using too much disk I/O. It’s not quite as useful since you can’t set absolute numbers like you can with the bwlimit parameter, but it’s another thing you can consider.

# # Table

The syntax is:
```
rsync --bwlimit=KBPS src dst
rsync --bwlimit=KBPS [options] src dst
rsync --bwlimit=KBPS [options] src user@dst
rsync --bwlimit=KBPS [options] user@src /path/to/dir
rsync --bwlimit=KBPS -a -P /path/to/dir/ user@server1.cyberciti.biz
```
You set I/O limit in 1000 KBytes per second:
```
$ rsync --bwlimit=1000 /path/to/source /path/to/dest/
$ rsync --bwlimit=1000 /var/www/html/ \
backups@server1.cyberciti.biz:~/mysite.backups/
```
In this example, pull files from FreeNAS server with 5000KB/s in current directory:
```
$ rsync --bwlimit=5000 --delete -P -az -H --numeric-ids \
vivek@192.168.2.30:linode-www .
```
# Say hello to ionice

Use ionice command to set or get the I/O scheduling class and priority for a program such as rsync or your own backup script. So you can take control of I/O bandwidth using ionice utility on Linux as follows:

```
# /usr/bin/ionice -c2 -n7 /root/scripts/nas.backup.full
```
- OR
```
# /usr/bin/ionice -c2 -n7 rsync \
-bwlimit=1000 /path/to/source /path/to/dest/ 
```
- Where:
```

1.    -c or --class {class} : Name or number of scheduling class, 0: none, 1: realtime, 2: best-effort, 3: idle.
2.    -n or --classdata {num} : priority (0..7) in the specified scheduling class, only for the realtime and best-effort classes
```

# WARNING: The "rsync" protocol witch not setting up can be slowing all your internet traffic!
