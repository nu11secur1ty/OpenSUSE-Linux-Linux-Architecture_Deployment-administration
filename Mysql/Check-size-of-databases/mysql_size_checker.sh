#!/bin/bash
mysql -u root -p <<EOFMYSQL
SELECT table_schema AS "Database", SUM(data_length + index_length) / 1024 / 1024 / 1024 AS "Size (GB)" FROM information_schema.TABLES GROUP BY table_schema\G;
EOFMYSQL
  exit 0;
