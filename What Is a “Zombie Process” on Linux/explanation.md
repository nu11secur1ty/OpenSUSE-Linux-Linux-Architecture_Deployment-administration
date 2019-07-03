If you’re a Linux user, you may have seen zombie processes shambling around your processes list. You can’t kill a zombie process because it’s already dead – like an actual zombie.

Zombies are basically the leftover bits of dead processes that haven’t been cleaned up properly. A program that creates zombie processes isn’t programmed properly – programs aren’t supposed to let zombie processes stick around.

---------------------------------------------------------------------------------------------------------------

- The Zombie Process is?

To understand what a zombie process is and what causes zombie processes to appear, you’ll need to understand a bit about how processes work on Linux.

When a process dies on Linux, it isn’t all removed from memory immediately — its process descriptor stays in memory (the process descriptor only takes a tiny amount of memory). The process’s status becomes EXIT_ZOMBIE and the process’s parent is notified that its child process has died with the SIGCHLD signal. The parent process is then supposed to execute the wait() system call to read the dead process’s exit status and other information. This allows the parent process to get information from the dead process. After wait() is called, the zombie process is completely removed from memory.

This normally happens very quickly, so you won’t see zombie processes accumulating on your system. However, if a parent process isn’t programmed properly and never calls wait(), its zombie children will stick around in memory until they’re cleaned up.

Utilities like GNOME System Monitor, the top command, and the ps command display zombie processes.

![](https://github.com/nu11secur1ty/OpenSUSE-Linux-Linux-Architecture_Deployment-administration/blob/master/What%20Is%20a%20%E2%80%9CZombie%20Process%E2%80%9D%20on%20Linux/shot/1.png)

- Dangers of Zombie Processes

Zombie processes don’t use up any system resources. (Actually, each one uses a very tiny amount of system memory to store its process descriptor.) However, each zombie process retains its process ID (PID). Linux systems have a finite number of process IDs – 32767 by default on 32-bit systems. If zombies are accumulating at a very quick rate – for example, if improperly programmed server software is creating zombie processes under load — the entire pool of available PIDs will eventually become assigned to zombie processes, preventing other processes from launching.

However, a few zombie processes hanging around are no problem – although they do indicate a bug with their parent process on your system.

