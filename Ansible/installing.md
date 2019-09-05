# Installing and configuring ansible in OpenSUSE Leep 15.1
- Install ansible
```bash
zypper install -y ansible
```
***Configure***
- uncomment `[[webservers]]` #line 30
- then in `/etc/ansible/hosts` change the IP of the server with your domain or IP #line 33

```bash
# This is the default ansible 'hosts' file.
#
# It should live in /etc/ansible/hosts
#
#   - Comments begin with the '#' character
#   - Blank lines are ignored
#   - Groups of hosts are delimited by [header] elements
#   - You can enter hostnames or ip addresses
#   - A hostname/ip can be a member of multiple groups

# Ex 1: Ungrouped hosts, specify before any group headers.

## green.example.com
## blue.example.com
## 192.168.100.1
## 192.168.100.10

# Ex 2: A collection of hosts belonging to the 'webservers' group

[webservers]
## alpha.example.org
## beta.example.org
 192.168.1.93
## 192.168.1.110

# If you have multiple hosts following a pattern you can specify
# them like this:

## www[001:006].example.com

# Ex 3: A collection of database servers in the 'dbservers' group

## [dbservers]
## 
## db01.intranet.mydomain.net
## db02.intranet.mydomain.net
## 10.25.1.56
## 10.25.1.57

# Here's another example of host ranges, this time there are no
# leading 0s:

## db-[99:101]-node.example.com
```
# Test the server
- NOTE: Before you do that you must set up ssh pub key between these two machines!
Then you must set up these two machines to seeing each other, himself in `/etc/hosts`
```bash
ansible webservers -m ping
```
# Installing the software and test the server controller
- On the ansible server

```bash 
ansible webservers -a "zypper install -y apache2"
ansible webservers -a "rcapache2 start"
```
# Create a simple Hello Ansible app
- On the webserver - target
```bash 
vim /srv/www/htdocs/index.html
```
- add:
```html
<h1>Hello Ansible</h1>
```
# Good luck friends and have fun! ;)
