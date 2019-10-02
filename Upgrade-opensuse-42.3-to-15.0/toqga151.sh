#!/usr/bin/bash
# Author @nu11secur1ty
# Update old version
zypper up -y
zypper dup -y
# Upgrade 
  sleep 3;
sed -i 's/15.0/15.1/' /etc/zypp/repos.d/*
  zypper refresh
  zypper up -y
  zypper dup -y
  zypper dup --download-in-advance 
  telinit 6
exit 0;
