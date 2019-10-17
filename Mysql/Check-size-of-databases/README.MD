#  get size of mysql databases;
- in MB
```bash
MariaDB [(none)]> SELECT table_schema AS "Database", SUM(data_length + index_length) / 1024 / 1024 AS "Size (MB)" FROM information_schema.TABLES GROUP BY table_schema;
```
- in BG
```bash
SELECT table_schema AS "Database", SUM(data_length + index_length) / 1024 / 1024 / 1024 AS "Size (GB)" FROM information_schema.TABLES GROUP BY table_schema;
```

- Output MB
```
+--------------------+------------+
| Database           | Size (MB)  |
+--------------------+------------+
| information_schema | 0.15625000 |
| kur                | 0.01562500 |
| mysql              | 2.41118526 |
| odds               | 0.01562500 |
| performance_schema | 0.00000000 |
| sys                | 0.01562500 |
+--------------------+------------+
6 rows in set (0.02 sec)

mysql> 
```
- Output BG
```
+--------------------+----------------+
| Database           | Size (GB)      |
+--------------------+----------------+
| information_schema | 0.000152587891 |
| kur                | 0.000015258789 |
| mysql              | 0.002354673110 |
| odds               | 0.000015258789 |
| performance_schema | 0.000000000000 |
| sys                | 0.000015258789 |
+--------------------+----------------+
6 rows in set (0.02 sec)

mysql> 
```
# BR nu11secur1ty
