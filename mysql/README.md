# 快速开始

```
docker run -d --name mysql -e MYSQL_ROOT_PASSWORD=${secret} mysql:8.0
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
# set 语句是为了加快插入速度
SET autocommit=0;source the_sql_file.sql;COMMIT;
```

# Import Data by mysqlimport

https://dev.mysql.com/doc/refman/8.0/en/mysqlimport.html#option_mysqlimport_local

# 可视化工具

https://dev.mysql.com/downloads/workbench/

# FAQ

### 中文乱码?

修改配置文件 mysqld.cnf 如下:

```
[mysqld]
character-set-server=utf8

[client]
default-character-set=utf8

[mysql]
default-character-set=utf8
```
再重新插入或导入数据
