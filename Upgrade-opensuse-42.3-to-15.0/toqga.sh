#!/usr/bin/bash
zypper up -y
zypper dup -y
sed -i 's/42.3/15.0/' /etc/zypp/repos.d/*
  zypper refresh
    zypper dup --download-in-advance -y
    zypper addrepo http://download.opensuse.org/repositories/devel:/languages:/php:/php56/openSUSE_Leap_42.3/devel:languages:php:php56.repo
  zypper in apache2 -y    
      zypper in -y php5 php5-mysql apache2-mod_php5
      a2enmod php5
  telinit 6
exit 0;
