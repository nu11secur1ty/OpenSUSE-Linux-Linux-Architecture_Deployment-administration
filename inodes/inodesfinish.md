What to do when a Linux system is running out of available inodes


Many popular file systems for Unix-like operating systems put aside some of their storage capacity for an inode table.
The inode table keeps track of every file and directory on the file system, and every file and directory on a disk requires one inode entry as well as allocated physical storage space on which to save the data. If you’ve got free available storage space on your system but keep getting error messages such as “No space left on device”; you’re likely facing issues with not having sufficient space left in your inode table. Here is how to identify and handle such a situation on a Linux system.

Run the following command to check your system’s available inode table capacity:

df --inodes

Filesystem      Inodes   IUsed   IFree IUse% Mounted on
tmpfs           127126     370  126756    1% /run
/dev/vda1      1966080 1826080 1881064   93% /

In the column marked IUse%, you shouldn’t generally see high numbers and you most definitely shouldn’t see 100%. 
If none of your disks are showing high numbers than you’re not about to run out of inodes. 
However, if this is your problem then do read on to learn how to deal with the situation.
Advertisement


First off, you generally can’t increase the available inode count on your system without formatting the drive and reserving a larger chunk of space for a larger filesystem inode table. 
Increasing a drive’s inodes that way is usually inconvenient and often not really the solution you’re looking for anyway.


Unless you’re dealing with a very large number of tiny files, the default number of inodes should be more than enough for most use cases. 
That default depends on your Linux distribution and filesystem, but for the very common Ext3 and Ext4 filesystems it is typically one inode per 16 KiB of disk space. 
Practically, that means that as long as your average filesize is larger than 16 KiB, you will run out of disk space before you run out of inodes.

Since the number of inodes scales with the size of the disk, but the number of files a given program creates usually doesn’t, you are more likely to run into the inode limit on a smaller filesystem. 
If you have a small virtual private server with a 20 GiB disk, you also have a limit of about 1,3 million files and directories. 
That can get uncomfortably tight when combined with e.g. mod_disk_cache module in the Apache web server. 
Moving up to a 200 GiB disk would also increase the number of inodes available tenfold, though paying extra for disk space you’re not really using does not feel right.

As we’ve now already identified that your system is indeed running out of available inodes, you should next figure out where all your inodes are being spent. 
As often will be the case, your inodes are being consumed by literally millions of small files created by a misconfigured or misbehaving subsystem. 
Run the following command to identify the directory and thus the system that is using all your inodes:

du --inodes -d 3 / | sort -n | tail

Note that it can take several minutes to run this command so go get yourself something good to drink while you wait. The command will eventually output a sorted list of the directories on your system that use the most number of inodes. From this information, you should be able to identify the misbehaving subsystem. Usually, you can start cleaning out the unexpected files and get to work on identifying how they were created to prevent it from happening again.

If it’s actually not a misbehaving system that is using up all your inodes but actually valuable user or system data; then you need to make other arrangement to store said data. If you have a lot of available space left on the drive, but no inodes; you can consider converting (that means backup!) the filesystem to a filesystem that doesn’t reserve a fixed amount of inodes, like XFS, JFS, BTRFS or even ZFS. Alternatively, you can reformat the disk and assign more of the disk to maintain the inodes table, using the -i flag to mkfs.ext4 to specify the bytes:inode ratio. You can also package up older and irrelevant files that should be archived and move them to another hard disk or partition with more inodes which will be more suited to store this kind of data. In any case, you’ve got somewhat unusual storage needs and accordingly will need to take the extra time to design a storage solution for it.

Up until last week, I was only tangentially aware that inode table space could theoretical run out and cause problems on a computer system. I then had a problematic encounter with Apache’s disk cache system (mod_cache_disk) where it’s storage quota and clean-up utility, the oddly named htcacheclean, had failed to limit the growth of the disk cache. I must say I’m surprised that things kept working as well as they did for as long as they did considering no new files could be created. The incident happened on the web server that runs this and most other of my websites, and service was maintained almost perfectly despite the big system limitation of not being able to create any new files. Good on you, Linux!
