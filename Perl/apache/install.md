

# For standard run the following as root:
# Add repository
```
[devel_languages_perl]
name=perl modules (openSUSE_Tumbleweed)
type=rpm-md
baseurl=http://download.opensuse.org/repositories/devel:/languages:/perl/openSUSE_Tumbleweed/
gpgcheck=1
gpgkey=http://download.opensuse.org/repositories/devel:/languages:/perl/openSUSE_Tumbleweed/repodata/repomd.xml.key
enabled=1
```
# Refresh
```
zypper refresh
```
# Install
```
zypper install perl-Module-Install-Repository
```

