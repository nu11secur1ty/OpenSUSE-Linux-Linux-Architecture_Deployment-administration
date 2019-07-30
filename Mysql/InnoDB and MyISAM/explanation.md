# InnoDB: 
A transaction-safe (ACID compliant) storage engine for MySQL that has commit, rollback, and crash-recovery capabilities to protect user data. InnoDB row-level locking (without escalation to coarser granularity locks) and Oracle-style consistent nonlocking reads increase multi-user concurrency and performance. InnoDB stores user data in clustered indexes to reduce I/O for common queries based on primary keys. To maintain data integrity, InnoDB also supports FOREIGN KEY referential-integrity constraints. InnoDB is the default storage engine as of MySQL 5.5.5.

# MyISAM: 
The MySQL storage engine that is used the most in Web, data warehousing, and other application environments. MyISAM is supported in all MySQL configurations, and is the default storage engine prior to MySQL 5.5.5.

For example, customer bank records might be grouped by customer in InnoDB but by transaction date with MyISAM, so InnoDB would likely require fewer disk seeks and less RAM to retrieve and cache a customer account history

The major differences between these two storage engines are :

 - InnoDB supports transactions which is not supported by tables which use MyISAM storage engine.
 - InnoDB has row-level locking, relational integrity i.e. supports foreign keys, which is not possible in MyISAM.
 - InnoDB ‘s performance for high volume data cannot be beaten by any other storage engines available.

Tables created in MyISAM are known to have higher speed compared to tables in InnoDB. But since InnoDB supports volume, transactions, integrity it’s always a better option which you are dealing with a larger database. A single database can have tables of different storage engines.
To check engines you can use command:
mysql> Show engines;
You can change the engine while creating the table by command:
CREATE TABLE test name varchar(30) ENGINE = InnoDB;
It is also possible to convert from one engine to the other by command:
ALTER TABLE my_table ENGINE=new_engine;
When you will execute the above command, complete process will be as such – the table will get locked, dumped to a tmp space, then rebuilt with the new engine. Also you will be losing innodb-only info (foreign keys, etc.) and features if you’re going to MyISAM.

---------------------------------------------------------------------------------------------------------------------------

# What is the difference between MyISAM and InnoDB?

When you create a table in MySQL,1) you can choose a storage engine. The storage engine is the way the table data is stored in files.2) There exist several different storage engines, but the most commonly used ones are MyISAM and InnoDB, each of which are the default storage engine in different MySQL versions. If you do not specify a storage engine when creating a table, the default engine for your MySQL version will be used. In MySQL versions earlier than 5.5.5, MyISAM was default, but in versions 5.5.5 and later, InnoDB is the default.3) In most cases, MyISAM is recommended, but there are some cases where for a particular table InnoDB might be recommended instead.

# General Comparison

Here is a very brief overview of common types of situations where one of these two engines might be better to use than the other.

- When to use MyISAM instead of InnoDB

In general, if a MyISAM table has a problem, the problem will be limited to that table, rather than affecting the functionality of other tables or databases as can sometimes happen when an InnoDB table has a problem. For this reason, MyISAM is recommended whenever possible in servers with multiple sites.

# When to use InnoDB instead of MyISAM

- Because InnoDB makes more extensive use of row-level locks instead of table-level locks, using InnoDB for specific tables that get written to frequently can help reduce the amount of time waiting for locks. This can in turn substantially reduce memory usage in the server in these specific cases.
- In part because databases using InnoDB tables cannot be individually restored as part of a Partial VPS Restore, and in part because some types of issues with InnoDB tables can cause data loss in other InnoDB tables, it is even more important than usual to make sure automatic backups are enabled and successfully being created, if any of the sites are using InnoDB.
- In part because issues with InnoDB tables can affect access to other databases, if a site has need for enough concurrent table writes to justify using InnoDB, that site might be busy enough to start considering putting it on its own server. If the site is not yet big enough for its own server, it might be better instead to recode the site to require less concurrency of table writes.

# When to use neither MyISAM nor InnoDB

- Most types of sites store session information as files, but if it must be stored in a database table, MEMORY is likely a better choice of engine than either MyISAM or InnoDB.
- Similarly, though it is even more rare, certain kinds of site cache data if being stored in a database table should probably use the MEMORY storage engine.

# How to Change a Table's Storage Engine

If you already have a table created that needs to be changed to a different engine, this can be done with an ALTER TABLE statement, like this:

```mysql
mysql> ALTER TABLE dbname.tablename ENGINE = enginename;
```
If you prefer to use phpMyAdmin, you would need to select the table: 

![](https://github.com/nu11secur1ty/OpenSUSE-Linux-Linux-Architecture_Deployment-administration/blob/master/Mysql/InnoDB%20and%20MyISAM/screen/1.png)

- click the "Operations" tab: 

![](https://github.com/nu11secur1ty/OpenSUSE-Linux-Linux-Architecture_Deployment-administration/blob/master/Mysql/InnoDB%20and%20MyISAM/screen/2.png)

- select the desired engine in the "Storage Engine" dropdown box: 

![](https://github.com/nu11secur1ty/OpenSUSE-Linux-Linux-Architecture_Deployment-administration/blob/master/Mysql/InnoDB%20and%20MyISAM/screen/3.png)

- and click the "Go" button: 

![](https://github.com/nu11secur1ty/OpenSUSE-Linux-Linux-Architecture_Deployment-administration/blob/master/Mysql/InnoDB%20and%20MyISAM/screen/4.png)

Congratulations! You have now changed the storage engine of the table!

# More Technical Explanation

Here is a little bit of more detailed information about the storage engines, to help explain why different ones are better for different purposes.
Similarities

    Any database table, regardless of which storage engine it uses, will have a .frm file. This file's name will be the table name followed by this file extension. This file contains table metadata, such as the table definition. Depending on the table's engine5) there may or may not be other files associated with the table.

# MyISAM

    A MyISAM table has a total of three files. In addition to the .frm file that all tables have, there is also a .MYD file containing the table data, and a .MYI file containing the indexes.
    Because MyISAM stores all table information directly within that table's three files, a single crashed table will not directly interfere with the functionality of other tables.
    Because MyISAM stores all table information directly within that table's three files, it is possible if needed to restore a single database from a Partial VPS Restore, if all tables in that database are using MyISAM.

# InnoDB

- An InnoDB table will have one or two files, depending on if innodb_file_per_table is enabled.
- Whether it is enabled or not, the table will still have an .frm file, containing the table definition, as all tables do.
- If it is enabled, there will also be an .ibd file, containing table data and indexes.
- If it is not enabled, the table data and indexes for all tables will instead be stored in the system tablespace.6)
- Due to the change buffer, even if innodb_file_per_table is enabled, recent changes will not yet be written to the table files. This is why databases containing InnoDB tables cannot be individually restored as part of a Partial VPS Restore, which in turn is part of why it is even more important than usual to have automatic backups enabled when InnoDB tables exist.
- InnoDB has an automatic crash recovery process. When mysql stops unexpectedly, InnoDB has certain checks that run at mysql startup. In most cases, this crash recovery process will successfully finalize changes committed before the crash and undo changes that were in progress but not committed. However, sometimes this process fails, especially if InnoDB is being particularly active at a time when MySQL is shutdown particularly uncleanly. When this happens, MySQL will be completely unable to start, and no databases will be accessible. For this reason, it is strongly recommended that if a site needs enough table write concurrency to justify using InnoDB, that that site be on its own server, to help prevent it from contributing to other sites being down.
- Additionally, if InnoDB crashes and is unable to recover automatically, it is possible for some of the InnoDB tables to be corrupted in a non-repairable way. This is another reason it is particularly important to have automatic backups enabled for any account using InnoDB tables.

# MEMORY

- A MEMORY table will only have one file: the .frm file itself, containing the table definition. The table data is stored only in memory.
- If mysql is restarted, data in a MEMORY table is lost. This might not be a problem if it is ephemeral data that is not needed for very long.
- Unlike internal temporary tables, which can be written to disk if they exceed a configured size,7) a MEMORY table will never be written to disk. A MEMORY table cannot exceed the size indicated by max_heap_table_size. If the table is filling up, you will need to add more places in the site scripts where the table is emptied.
- MEMORY tables, like MyISAM tables, use table-level locks for certain operations, but because the changes are not written to the disk, this is still usually much faster than the same operations in a MyISAM table.8)
 - Because data from MEMORY tables is lost when mysql is restarted, corrupted MEMORY table data cannot prevent mysql from starting.
- MEMORY tables should only be used for ephemeral, non-persistant data, that is only needed for short periods of time.

# Summary

If a table is composed entirely of ephemeral data that does not need to be kept long, it may be better to store it in MEMORY tables, to combine speed with compartmentalization.

If a table is not often written to,9) especially on a server with many sites, it is likely safest to store it as MyISAM, to better compartmentalize issues in case of the rare instances where InnoDB crash recovery would fail.

If a table is frequently written to and contains non-ephemeral data, then the table should be stored as InnoDB to prevent lock competition from using up too many server resources. If using InnoDB for a table, it is even more important than usual to make sure that cPanel account has automatic backups enabled. If a site is busy enough to need InnoDB tables, it may be time to consider putting the site on its own server, to help prevent an InnoDB failure from affecting other sites.







