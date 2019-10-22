#!/usr/bin/bash
# Update old version
# Author V.Varbanovski @nu11secur1ty
zypper up -y
zypper dup -y
# Upgrade 
  sleep 3;
  # test
sed -i 's/42.3/15.2/' /etc/zypp/repos.d/*
  zypper refresh
  zypper dup --download-in-advance 
  telinit 6
exit 0;
