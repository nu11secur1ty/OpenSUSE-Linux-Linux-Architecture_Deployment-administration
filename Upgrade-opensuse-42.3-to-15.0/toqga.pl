#!/usr/bin/perl
use warnings;
use strict;
use diagnostics;

my $check_lat_up = `zypper up -y`;
my $check_lat_dup = `zypper dup -y`;
my $addnew_repo = `sed -i 's/42.3/15.0/' /etc/zypp/repos.d/*`;
my $refresh_new_repo = `zypper refresh`;
my $upgrade_new_repo = `zypper dup --download-in-advance -y`;
my $reload = `telinit 6`;
