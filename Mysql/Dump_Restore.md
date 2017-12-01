# Dump single table
```
mysqldump db_name table_name | gzip > table_name.sql.gz
```
# Restore single table
```
gunzip < table_name.sql.gz | mysql -u username -p db_name
```
