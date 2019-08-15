# For example, say you have a directory called `/home/gosho/prog` and you would like to compress this directory then you can type tar command as follows:
```bash
tar -zcvf prog-1-jan-2005.tar.gz /home/gosho/prog
```

# If you wish to extract files in particular directory, for example in /tmp then you need to use the following command:

```bash
$ tar -zxvf prog-1-jan-2005.tar.gz -C /tmp
$ cd /tmp
$ ls -
```
# To compress directory named /home/nu11secur1ty/bin/ in to a /tmp/bin-backup.tar.gz type the tar command on Linux:
```bash
tar -zcvf /tmp/bin-backup.tar.gz /home/nu11secur1ty/bin/
```

# You can compress multiple directories too:

```bash
tar -zcvf my-compressed.tar.gz /path/to/dir1/ /path/to/dir2/
```

