## MySQL数据库备份
### Features
* Dump a single databases.
* Support dump for specifying database tables, default all tables.

### Usage :
* Dump all tables of a single databases.
```
docker run --rm -v $PWD:/mysqldump -e DB_NAME=db -e DB_PASS=password -e DB_USER=root -e DB_HOST=127.0.0.1 mysqldump:latest
```
* Dump for specifying database tables.
```
tables="account customer"
docker run --rm -v $PWD:/mysqldump -e DB_NAME=db -e DB_PASS=password -e DB_USER=root -e DB_HOST=127.0.0.1 -e DB_TABLES=$tables mysqldump:latest
```
