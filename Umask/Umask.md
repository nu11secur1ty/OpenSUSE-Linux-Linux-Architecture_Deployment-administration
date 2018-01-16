# The global umask value on OpenSuse is stored in:
``` 
/etc/login.defs 
```

# Type of masks if you want to change the umask of the profile.

``` 	      
            Files                                    Directories
Mask        (requested permissions 777)              (requested permissions 666)

002 	      664 (rw-rw-r--) 	                        775 (rwxrwxr-x)
007 	      660 (rw-rw----) 	                        770 (rwxrwx---)
022 	      644 (rw-r--r--) 	                        755 (rwxr-xr-x)
027 	      640 (rw-r-----) 	                        750 (rwxr-x---)
077 	      600 (rw-------) 	                        700 (rwx------)
277 	      400 (r--------) 	                        500 (r-x------)
```
# Change umask on OpenSuse leep 42 and to the othet OS, you shuld find where is the bash "profile"
```
 echo -e "umask 022" >> /etc/profile && source /etc/profile
```
