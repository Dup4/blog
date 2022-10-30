# How to migrate a MySQL database

## Migrating a database

```bash
mysqldump --set-gtid-purged=OFF --add-drop-database -h ${your mysql host} -u ${your username} -p --databases ${your database name} > ${your database name}.sql
```

## Reference

* [How do you mysqldump specific table(s)?](https://dba.stackexchange.com/questions/9306/how-do-you-mysqldump-specific-tables)
* [mysqldump with create database line](https://stackoverflow.com/questions/16452523/mysqldump-with-create-database-line)
