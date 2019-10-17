#!/usr/bin/bash
# Author V.Varbanovski @nu11secur1ty

truncate -s 0 /path/to/your/report/file/sqlreport.log

echo "Mysql-proc-monitor by V.Varbanovski ;)";
echo ""
echo ""
echo "===Time==="
timedatectl
echo "" 
echo "===Zombi==="
ps aux | awk {'print $8'}|grep -c Z
echo ""
echo "===Load-average==="
cat /proc/loadavg
echo ""
echo ""
echo "==============================================================="
# Input your user
user="user_name"
# Input your password
password="password"

# Checking a global status
#echo "===STATUS===";
#       mysql -u $user -p$password -e "SHOW GLOBAL STATUS;"
#       echo ""

echo "===Size of databases===";
mysql -u $user -p$password <<EOFMYSQL
SELECT table_schema AS "Database", SUM(data_length + index_length) / 1024 / 1024 AS "Size (MB)" FROM information_schema.TABLES GROUP BY table_schema\G;
EOFMYSQL
        echo ""
echo "===Processlist===";
        mysql -u $user -p$password -e "SHOW PROCESSLIST;"
        echo ""
echo "===Queriesi===";
        mysql -u $user -p$password -e "SHOW FULL PROCESSLIST\G;"
        echo ""
echo "===WARNINGS===";
        mysql -u $user -p$password -e "SHOW COUNT(*) WARNINGS;"

exit 0;
