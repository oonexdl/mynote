# 快速开始

```
docker run --name mysql -e MYSQL_ROOT_PASSWORD=${secret} mysql:8.0
```

# Import Data by Sql Console

```
# create database
docker exec -it mysql mysql -uroot -p
# enter password
```

```mysql
CREATE DATABASE XXXX;
use XXXX;
SET autocommit=0;source the_sql_file.sql;COMMIT;
```

# Import Data by mysqlimport

https://dev.mysql.com/doc/refman/8.0/en/mysqlimport.html#option_mysqlimport_local

# 可视化工具

https://dev.mysql.com/downloads/workbench/
