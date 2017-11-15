
# Inodes - an Introduction
-------------------------------------------------------------------------------------------------------------------

We are used to thinking about a directory containing files. This is really an illusion. Directories do not contain files. The data of the files is not stored in the directory.

------------------------------------------------------------------------------------------------------------------

A directory is really just a file. It's a special file with special rules (you can't just type "cp /dev/null directory" to erase it. It's got special bits to make sure a mere mortal can't mess it up. Because if a file system gets corrupted, then you can say goodbye to your data. On older UNIX systems, you actually could "read" the contents, using 'cat .', of a directory. But let me get back to that in a second...

------------------------------------------------------------------------------------------------------------------

A Unix file is "stored" in two different parts of the disk - the data blocks and the inodes. (I won't get into superblocks and other esoteric information.) The data blocks contain the "contents" of the file. The information about the file is stored elsewhere - in the inode.

------------------------------------------------------------------------------------------------------------------

Both the inodes and data blocks are stored in a "filesystem" which is how a disk partition is organized. But these inodes are strange and confusing. Let me give you an introduction.
"ls -i" lists the inode of a file

Normal Unix/Linux/MacOS users aren't even aware that inodes exist. But there's an easy way to discover them - using the "ls -i" command. Let's look at the root file system:

------------------------------------------------------------------------------------------------------------------
```
% cd /
% ls -i
2637825 bin     983041 etc	       1572865 lib	   2981889 media  2531329 root	 106497 selinux    81921 usr
 196609 boot         2 home	       1761281 lib64	   2129921 mnt	     6416 run	2457601 srv	  425985 var
```
The "-i" option lists the inode number before the filename. The numbers look like large numbers, except for "home." Now let's get more information, and list some more files by added "-a" and "-l" options:
```
% ls -lai | tail -7
total 132
      2 drwxr-xr-x  24 root root   4096 Feb 26 13:31 .
      2 drwxr-xr-x  24 root root   4096 Feb 26 13:31 ..
2637825 drwxr-xr-x   2 root root   4096 Jan 14 19:02 bin
 196609 drwxr-xr-x   3 root root   4096 Feb 24 10:41 boot
      3 drwxr-xr-x  16 root root   4460 Mar  5 09:35 dev
 983041 drwxr-xr-x 206 root root  12288 Mar  5 07:45 etc
      2 drwxr-xr-x  14 root root   4096 Dec 29 09:24 home
```
That's interesting - three of the files have the inode value of "2". But as you shall see, this makes perfect sense.

As Unix systems can support many different types of file systems, in the "classic" filesystem, inode #2 is always the root file system. If you want to look for a file, you start with inode #2 and work down into the directory structure. Normally the ".." directory points to the parent directory, but since "/" is the top of the tree, the parent of "/" is "/".

The "dev" directory has the inode "3". I suspect that when the filesystem was created, the "/dev" directory was the first file to be created.

--------------------------------------------------------------------------------------------------------------------

But, you may wonder, why does "home" have the inode of "2"? You have sharp eyes.

The reason is simple. It happens to be a different partition, and "/home" is the root of that partition.

Inodes are always unique, but unique per partition. To uniquely identify a file, you need the inode and the device (the disk partition).
What is in an inode?

Before I said the data blocks contain the contents of the file. The inode contains the following pieces of information
```
    Mode/permission (protection)
    Owner ID
    Group ID
    Size of file
    Number of hard links to the file
    Time last accessed
    Time last modified
    Time inode last modified 
```

As I said, a file system is divided into two parts - the inodes and data blocks. Once created, the number of blocks of each type is fixed. You can't increase the number of inodes on a partition, or increase the number of disk blocks. (See the manual pages on making and tuning file systems - mkfs.ext2).

--------------------------------------------------------------------------------------------------------------------

Notice something missing? Where is the NAME of the file. Or the Path? It's NOT in the inode. It's NOT in the data blocks. It's _in_ the directory. That's right. A "file" is really in three (or more) places on the disk.

--------------------------------------------------------------------------------------------------------------------

You see, the directory is just a table that contains the filenames in the directory, and the matching inode. Think of it as a table, and the first two entries are always "." and ".." The first points to the inode of the current directory, and the second points to the inode of the parent directory. By Definition. As spoken by the Gods of Unix. Verily.

--------------------------------------------------------------------------------------------------------------------

This inode-magic is how you can create a "hard link" - having two or more names for the same file. Think of a directory as a table, which contains the name and the inode of each file in the directory. This is an important point - the name of the file is only used in directory. You can have another directory "containing" the same file, but it can have a different name.

--------------------------------------------------------------------------------------------------------------------

When you create a hard link, it just created a new name in the table, along with the inode, without moving the file. When you move a file (or rename it), you don't copy the data. That would be Slow. You just create the (name,inode) entry in a new directory, and delete the old entry in the table inside the old directory entry. In other words, moving a gigabyte file takes very little time. In the same way, you can move/rename directories very easily. That's why "mv /usr /Old_usr" is so fast, even though "/usr" may contain (for example) 57981 files.

--------------------------------------------------------------------------------------------------------------------

You can see this "inode" stuff if you use the "ls -i" option. It lists the inode number. find(1) can use it as well. Let's also use the "-d" option to list information about the directory, rather than the contents of the directory.

---------------------------------------------------------------------------------------------------------------------

First - let's make a new directory using

```
cd /tmp
mkdir junk
cd junk

If you do a

        ls -id ..
        cd ..
        ls -id .
```
You will get results that look like this
```
/tmp/junk$ ls -id ..
327681 ..
/tmp/junk$ cd ..
/tmp$ ls -id .
327681 .
```
You will see that the these two "files" point to the same inode - which has the number 327681.

Now let's get more information from this directory.
```
$ ls -lad /tmp/junk
drwxrwxr-x 2 barnett barnett 4096 Mar  5 10:42 /tmp/junk
```
The second field has the value of "2" - which indicates that there are two hard links to this file. This makes sense because directories always have at least two names, as this shows.
```
/tmp/junk$ cd /tmp
/tmp$ ls -iad junk  # look at the file /tmp/junk
435297 junk
/tmp$ cd junk
/tmp/junk$ ls -iad . # look at the file "." in the /tmp/junk directory
435297 .
```
Puzzle time! I'm on a system, and I type two commands. Here are the commands and the results:
```
% cd
% ls -ld . ..
drwxr-xr-x   66 barnett  users       12288 Mar  7 18:43 .
drwxr-xr-x    6 root     root         4096 Feb 19  2012 ..
```
You should now know how many directories I have in my home directory, and how many other users have home directories on my system.

I'll give you a minute.

Remember, the file ".." always points to the parent directory. And remember that when I create a directory, the kernel creates the files "." and ".." inside the directory.

---------------------------------------------------------------------------------------------------------------------

Therefore every time I create a directory "underneath" my current directory, the new directory has an entry ".." - which is the parent directory.

---------------------------------------------------------------------------------------------------------------------

This means that since I have 66 "copies" or hard links to my home directory, that I must have 64 sub-directories underneath. We have to subtract 2 from the total, because we always start with 2 links.

----------------------------------------------------------------------------------------------------------------------

How many other directories are the the /home directory (my parent directory?) The answer is 3, so there are three other "users" who have home directories. That's not quite accurate as users much have an entry in the /etc/passwd file. In any case, because of the "6" value for the directory ".." we know there are 4 directories above my home directory, because we always subtract 2 for the directory itself, and we subtract one more for my directory - which leaves 3.
Using inodes

-----------------------------------------------------------------------------------------------------------------------

Inodes can be very useful to "ferret out" information about a file system. As I described above, it can tell you about different directories on a computer, and how many there should be. It might even help locate a hidden directory. Let's start with some simpler cases.
Finding files by inodes

If you know the inode, you can find it using the find command.

----------------------------------------------------------------------------------------------------------------------

```
$ find . -inum 435304 -print
```
Deleting files with strange names

Sometimes files are created with strange characters in the filename. The Unix file system will allow any character as part of a filename except for a null (ASCII 000) or a "/". Every other character is allowed.

----------------------------------------------------------------------------------------------------------------------

Hackers can create files with characters that make it difficult to see the directory or file. They can create the directory ".. " with a space at the end, or create a file that has a backspace in the name, using
```
touch `printf "aa\bb"`
```
Now what what happens when you use the "ls" command:
```
$ ls
aa?b
$ ls | grep 'a'
ab
```
Note that when "ls" sends the result to a terminal, it places a "?" in the filename to show an unprintable character.

You can get rid of this file by using "rm -i *" and it will prompt you before it deletes each file. But you can also use "find" to remove the file, once you know the inode number.
```
$ ls -i
435304 aa?b
$ find . -inum 435304 -delete
```
Checking the percentage of used inodes in a partition

I think we are all familiar with the problem of filling up a disk. The Unix command "df" will display each partition, and give a percentage of the disk blocks that are used.

It's also possible that there may be plenty of data blocks, but the number of inodes can be used up. And if this happens, no more new files can be created. The command "df -i" will display the percentage (and total) number of inodes on each partition.
The stat(2) system call
Here's the actual contents of the inode, according to the stat(2) manual page:
```
           struct stat {
               dev_t     st_dev;     /* ID of device containing file */
               ino_t     st_ino;     /* inode number */
               mode_t    st_mode;    /* protection */
               nlink_t   st_nlink;   /* number of hard links */
               uid_t     st_uid;     /* user ID of owner */
               gid_t     st_gid;     /* group ID of owner */
               dev_t     st_rdev;    /* device ID (if special file) */
               off_t     st_size;    /* total size, in bytes */
               blksize_t st_blksize; /* blocksize for file system I/O */
               blkcnt_t  st_blocks;  /* number of 512B blocks allocated */
               time_t    st_atime;   /* time of last access */
               time_t    st_mtime;   /* time of last modification */
               time_t    st_ctime;   /* time of last status change */
           };

```

