#!/usr/bin/bash
# Update old version
zypper up -y
zypper dup -y
# Upgrade 
  sleep 3;
sed -i 's/15.0/15.1/' /etc/zypp/repos.d/*
  zypper refresh
  zypper dup --download-in-advance 
  telinit 6
exit 0;
