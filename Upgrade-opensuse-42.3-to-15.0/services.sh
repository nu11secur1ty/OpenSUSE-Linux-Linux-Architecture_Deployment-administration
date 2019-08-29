#!/usr/bin/bash
  zypper addrepo http://download.opensuse.org/repositories/devel:/languages:/php:/php56/openSUSE_Leap_42.3/devel:languages:php:php56.repo
      sleep 5;
  zypper refresh
  zypper up -y
  zypper dup -y
      sleep 3;
  zypper in apache2 -y    
  zypper in php5 php5-mysql apache2-mod_php5 -y
      a2enmod php5
exit 0;
