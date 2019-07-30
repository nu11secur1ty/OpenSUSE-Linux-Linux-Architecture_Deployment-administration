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
General Comparison

Here is a very brief overview of common types of situations where one of these two engines might be better to use than the other.
When to use MyISAM instead of InnoDB

    In general, if a MyISAM table has a problem, the problem will be limited to that table, rather than affecting the functionality of other tables or databases as can sometimes happen when an InnoDB table has a problem. For this reason, MyISAM is recommended whenever possible in servers with multiple sites.

When to use InnoDB instead of MyISAM

    Because InnoDB makes more extensive use of row-level locks instead of table-level locks, using InnoDB for specific tables that get written to frequently can help reduce the amount of time waiting for locks. This can in turn substantially reduce memory usage in the server in these specific cases.
    In part because databases using InnoDB tables cannot be individually restored as part of a Partial VPS Restore, and in part because some types of issues with InnoDB tables can cause data loss in other InnoDB tables, it is even more important than usual to make sure automatic backups are enabled and successfully being created, if any of the sites are using InnoDB.
    In part because issues with InnoDB tables can affect access to other databases, if a site has need for enough concurrent table writes to justify using InnoDB, that site might be busy enough to start considering putting it on its own server. If the site is not yet big enough for its own server, it might be better instead to recode the site to require less concurrency of table writes.

When to use neither MyISAM nor InnoDB

    Most types of sites store session information as files, but if it must be stored in a database table, MEMORY is likely a better choice of engine than either MyISAM or InnoDB.
    Similarly, though it is even more rare, certain kinds of site cache data if being stored in a database table should probably use the MEMORY storage engine.

How to Change a Table's Storage Engine

If you already have a table created that needs to be changed to a different engine, this can be done with an ALTER TABLE statement, like this:4) 
