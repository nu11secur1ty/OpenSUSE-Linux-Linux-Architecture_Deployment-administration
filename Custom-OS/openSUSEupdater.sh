#!/usr/bin/bash
# Author nu11secur1ty
# more for custome OS: https://github.com/nu11secur1ty/insmod_block

sed -i 's/enabled=0/enabled=1/' /etc/zypp/repos.d/repo-oss.repo
sed -i 's/enabled=0/enabled=1/' /etc/zypp/repos.d/repo-update-non-oss.repo
        sleep 3;
        zypper up
        zypper dup
        sleep 3;
                sed -i 's/enabled=1/enabled=0/' /etc/zypp/repos.d/repo-oss.repo
                sed -i 's/enabled=1/enabled=0/' /etc/zypp/repos.d/repo-update-non-oss.repo
        sleep 3;
                zypper up
                zypper dup
exit 0;
