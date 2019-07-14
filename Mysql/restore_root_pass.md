Stop the MySQL service
(Ubuntu and Debian) Run the following command:

sudo /etc/init.d/mysql stop
(CentOS, Fedora, and Red Hat Enterprise Linux) Run the following command:

sudo /etc/init.d/mysqld stop
Start MySQL without a password
Run the following command. The ampersand (&) at the end of the command is required.

sudo mysqld_safe --skip-grant-tables &
Connect to MySQL
Run the following command:

mysql -uroot
Set a new MySQL root password
Run the following command:

use mysql;

update user set authentication_string=PASSWORD("mynewpassword") where User='root';

flush privileges;

quit
Stop and start the MySQL service
(Ubuntu and Debian) Run the following commands:

sudo /etc/init.d/mysql stop
...
sudo /etc/init.d/mysql start
(CentOS, Fedora, and Red Hat Enterprise Linux) Run the following commands:

sudo /etc/init.d/mysqld stop
...
sudo /etc/init.d/mysqld start
Log in to the database
Test the new password by logging in to the database.

mysql -u root -p
Enter your new password when prompted.
