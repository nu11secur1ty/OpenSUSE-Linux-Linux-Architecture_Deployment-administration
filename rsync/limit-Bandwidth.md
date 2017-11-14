If you use the rsync utility to keep your backups synchronized from your database server over to your backup or secondary file server, you might want to prevent the script from using too much bandwidth. Here’s how.

The point of limiting bandwidth is to make sure your backup scripts don’t clog up the network connection between your web server and database server. Naturally, limiting the amount of bandwidth your backups are using is going to make them happen more slowly, but if you can deal with that, this is the way to do it.

Normally your rsync command will look something like this:
```
rsync -a /backup/folder user@host:/remote/backup/folder/
```
