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

# WARNING: The "rsync" protocol witch not setting up can be slowing all your internet traffic!
