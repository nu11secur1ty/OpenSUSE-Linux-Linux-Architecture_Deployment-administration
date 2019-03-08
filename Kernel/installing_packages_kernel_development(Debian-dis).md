# SUSE
[link](https://github.com/nu11secur1ty/Compiling-the-Linux-Kernel-the-SUSE-way)

--------------------------------------------------------------------------------------------------------

# Search for kernel version (optional)

Type the following apt-cache command :

```
$ apt-cache search linux-headers-$(uname -r)
```

# OR

```
$ apt search linux-headers-$(uname -r)
```
# Install linux-header package under Debian or Ubuntu Linux

```
$ sudo apt-get install linux-headers-$(uname -r)
# apt-get install linux-headers-$(uname -r)
$ sudo apt-get install build-essential

```

#  Install Kernel Source Code And Headers

```
$ sudo apt-get update
$ sudo apt-get install linux-source 
```
# Tools
```
$ apt install libncurses5-dev libncursesw5-dev
$ install ncurses-devel
$ apt install gcc
- RHEL:
$ yum install ncurses-devel
$ dnf install ncurses-devel
```


