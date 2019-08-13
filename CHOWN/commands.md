# chown command
chown command changes the user and/or group ownership of for given file. The syntax is:

```bash
chown owner-user file 
chown owner-user:owner-group file
chown owner-user:owner-group directory
chown options owner-user:owner-group file
```

# Examples
- First, list permissions for demo.txt, enter:
```bash
# ls -l demo.txt
```
- Sample outputs:
```bash
-rw-r--r-- 1 root root 0 Aug 31 05:48 demo.txt
```
- In this example change file ownership to nu11secur1ty user and list the permissions, run:

```bash
# chown nu11secur1ty demo.txt
# ls -l demo.txt
```

- Sample outputs:

```bash
-rw-r--r-- 1 nu11secur1ty root 0 Aug 31 05:48 demo.txt
```

In this next example, the owner is set to nu11secur1ty followed by a colon and a group onwership is also set to vivek group, run:

```bash
# chown nu11secur1ty:nu11secur1ty demo.txt
# ls -l demo.txt
```

- Sample outputs:

```bash
-rw-r--r-- 1 nu11secur1ty nu11secur1ty 0 Aug 31 05:48 demo.txt
```

In this example, change only the group of file. To do so, the colon and following GROUP-name ftp are given, 
but the owner is omitted, only the group of the files is changed:

```bash
# chown :ftp demo.txt
# ls -l demo.txt
```
- Sample outputs:

```bash
-rw-r--r-- 1 nu11secur1ty ftp 0 Aug 31 05:48 demo.txt
```

Please note that if only a colon is given, or if NEW-OWNER is empty, neither the owner nor the group is changed:
```bash
# chown : demo.txt
```

In this example, change the owner of /foo to “root”, execute:
```bash
# chown root /foo
```
Likewise, but also change its group to “httpd”, enter:
```bash
# chown root:httpd /foo
```
Change the owner of /foo and subfiles to “root”, run:
```bash
# chown -R root /u
```
Where,

- -R – Recursively change ownership of directories and their contents.
