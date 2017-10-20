

# For standard run the following as root:
# Add repository openSUSE_Leap_42.3
```
zypper addrepo http://download.opensuse.org/repositories/devel:/languages:/perl/openSUSE_Leap_42.3/devel:languages:perl.repo
```
```
zypper refresh
```
```
zypper install perl-Module-Install-Repository
```
# Manual


```
vim /etc/zypp/repos.d/perl_mod.repo
```
- Add inside
```
[devel_languages_perl]
name=perl modules (openSUSE_Leap_42.3)
type=rpm-md
baseurl=http://download.opensuse.org/repositories/devel:/languages:/perl/openSUSE_Leap_42.3/
gpgcheck=1
gpgkey=http://download.opensuse.org/repositories/devel:/languages:/perl/openSUSE_Leap_42.3/repodata/repomd.xml.key
enabled=1
```
- Refresh
```
zypper refresh
```
- Install
```
zypper install perl-Module-Install-Repository
```

