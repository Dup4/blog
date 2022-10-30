# How to migrate a MySQL database

## Migrating a database

```bash
mysqldump --set-gtid-purged=OFF --add-drop-database -h ${your mysql host} -u ${your username} -p --databases ${your database name} > ${your database name}.sql
```
