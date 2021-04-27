#!/usr/bin/bash
# Author @nu11secur1ty
# Update old version
zypper up -y
zypper dup -y
# Upgrade 
  sleep 3;
# rm /etc/zypp/repos.d/openSUSE-Leap-15.1-1.repo
## Sources
# $releasever
# 15.1 > 15.2
sed -i 's/15.1/15.2/' /etc/zypp/repos.d/*
# sed -i 's/$releasever/15.2/' /etc/zypp/repos.d/*
  zypper refresh
    mv /usr/share/doc/packages/kernel-syms/README.SUSE /usr/share/doc/packages/kernel-syms/README.SUSE.BACK
  zypper up -y
  zypper dup -y
  zypper dup --download-in-advance
  telinit 6
exit 0;
