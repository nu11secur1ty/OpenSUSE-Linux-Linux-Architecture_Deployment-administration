#  get size of mysql databases;
```bash
MariaDB [(none)]> SELECT table_schema AS "Database", SUM(data_length + index_length) / 1024 / 1024 AS "Size (MB)" FROM information_schema.TABLES GROUP BY table_schema;
```
- Output
```
mysql> SELECT table_schema AS "Database", SUM(data_length + index_length) / 1024 / 1024 AS "Size (MB)" FROM information_schema.TABLES GROUP BY table_schema;
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
# BR nu11secur1ty
