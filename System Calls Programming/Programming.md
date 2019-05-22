# What is a system call?

Before we start implementing system calls, we’d better make sure we understand exactly what they are. A naive programmer—like me not that long ago—might define a system call as any function provided by the C library. But this isn’t quite true. Although many functions in the C library align nicely with system calls (like chdir), other ones do quite a bit more than simply ask the operating system to do something (such as fork or fprintf). Still others simply provide programming functionality without using the operating system, such as qsort and strtok.

In fact, a system call has a very specific definition. It is a way of requesting that the operating system kernel do something on your behalf. Operations like tokenizing a string don’t require interacting with the kernel, but anything involving devices, files, or processes definitely does.

System calls also behave differently under the hood than a normal function. Rather than simply jumping to some code from your program or a library, your program has to ask the CPU to switch into kernel mode, and then go to a predefined location within the kernel to handle your system call. This can be done in a few different ways, such as a processor interrupt, or special instructions such as syscall or sysenter. In fact, the modern way of making a system call in Linux is to let the kernel provide some code (called the VDSO) which does the right thing to make a system call. Here’s an interesting SO question on the topic.

Thankfully, all that complexity is handled for us. No matter how a system call is made, it all comes down to looking up the particular system call number in a table to find the correct kernel function to call. Since all you need is a table entry and a function, it’s actually very easy to implement your own system call. So let’s give it a shot!

---------------------------------------------------------------------------------------------------------------------

# Set up your VM

Unlike my previous articles on kernel development, implementing a system call is not something you can do in a kernel module. Instead, you must actually get a copy of the Linux source, modify it, compile it, and boot it. This is something you could do directly on your main computer (if you run Linux), but it’s probably best to try this out on a virtual machine! For this example, we’ll be using VirtualBox, so install it if you don’t already have it.

Although you can mess around with setting up a virtual machine manually, it’s more worth your time to simply download a pre-installed virtual machine. You can download a premade Arch Linux machine here. In this article, I’ll be using the 201608 CLI version for VirtualBox. Download and unzip it. Create a new virtual machine in VirtualBox, and when it asks about a hard disk file, choose the vdi file you downloaded. Create and run your virtual machine, and you should be greeted with a CLI login screen. The root password should have been noted on the download page (mine was osboxes.org).

Note: if you have a multicore machine, it would be a good idea to edit your VM settings to allow it to use more than one core. This will dramatically improve your compile times, so long as you substitute  make -jN for  make in all following commands, where N is the number of cores you give your VM access to.

The first preparation step you should take is to install bc, a build-time dependency of Linux that isn’t included in the virtual machine. Unfortunately, this will require that you update the virtual machine first. Note that every command I give in this article should be run as root, which shouldn’t be hard, because the only user on your VM is, in fact, root.

[Link:](https://www.osboxes.org/opensuse/#opensuse-42-3-leap-vmware)
