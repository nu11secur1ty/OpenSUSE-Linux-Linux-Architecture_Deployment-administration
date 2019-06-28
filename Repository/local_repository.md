### $ Publix repo ###
### SLES 12


blkid /dev/sr0                         -  check for UUID

mkdir /mnt/cdrom

mount -t iso9660 /dev/sr0 /mnt/cdrom   - mount your dvd in to a /mnt/cdrom 

mkdir /root/Repo_SLES_12_SP_2

cd /mnt/cdrom/

cp -pr * /root/Repo_SLES_12_SP_2

watch -n1 du -sh 



##############################################################
# Install Apache

zypper in apache2

rcapache2 start

systemctl enable apache2

chkconfig apache2 on


# Repository
# Add PHP5:
# NOTE, Use REPO which OS you use!
  

zypper ar -f -c http://download.opensuse.org/repositories/devel:/languages:/php:/php56/openSUSE_Leap_42.2/ Publix-PHP56

zypper dup --from Publix-PHP56

zypper in php5 php5-mysql apache2-mod_php5

# Preparing

a2enmod php5

systemctl restart apache2

zypper in mariadb mariadb-tools

systemctl start mysql

mysql_secure_installation


#############################################################
# Add third part:

SLES 12 SP1

Use OpenSUSE 13.1 repos:

zypper ar -f -c http://download.opensuse.org/distribution/13.1/repo/oss/ Publix-SUSE13.1            -  WORK
zypper ar -f -c http://download.opensuse.org/distribution/13.1/repo/non-oss/ Publix-SUSE13.1-non-oss
zypper ar -f -c http://download.opensuse.org/update/13.1/ Publix-SUSE
zypper ar -f -c http://download.opensuse.org/update/13.1-non-oss/ Publix-SUSE13.1-non

the above will allow installation of apps like xmgrace, ImageMagik etc.

For apps like ffmpeg, mplayer, vlc etc, use Packman

http://ftp.twaren.net/Linux/Packman/suse/SLE_12/ 
http://ftp.twaren.net/Linux/Packman/suse/openSUSE_13.1/  



