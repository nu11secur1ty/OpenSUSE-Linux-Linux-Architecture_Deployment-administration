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


