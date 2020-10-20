#!/usr/bin/bash
zypper addrepo https://download.opensuse.org/repositories/openSUSE:Factory/standard/openSUSE:Factory.repo
zypper -n refresh 
zypper install -n usb_modeswitch
