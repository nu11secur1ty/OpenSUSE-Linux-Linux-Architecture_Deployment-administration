# Run vlc player as root user
- Login as root
```
su -
```
# Run this command:
```
sed -i 's/geteuid/getppid/' /usr/bin/vlc
```
