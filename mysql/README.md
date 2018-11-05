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
source path_sql_file;
```

# Import Data by mysqlimport
