## Auth

启动一个新的 mongodb(3.4) 实例后，需要创建管理员用户并激活授权机制。

流程如下:

### 关闭授权

- 将 /etc/mongod.conf 中 security.authorization 设置为 disabled, 重启实例 service mongod restart 或

- 以 `mongod --port 27017 --dbpath /data/db1` 方式启动

### 创建管理员账户，并授予角色

```shell
# 启动 mongo shell
mongo 

use admin
db.createUser(
  {
    user: "administrator",
    pwd: "abc123",
    roles: [ 
      { role: "userAdminAnyDatabase", db: "admin" } 
    ]
  }    
)
```
### 开启授权并重新启动 mongod

- /etc/mongod.conf 中 security.authorization 设置为 enabled, 重启实例 service mongod restart 或

- 以 `mongod --auth --port 27017 --dbpath /data/db1` 方式启动

### 使用管理员用户连接 mongod

- 在连接时授权

```shell
mongo -u "administrator" -p "abc123" --authenticationDatabase "admin"
```

- 连接后授权

```shell
mongo
use admin
db.auth("administrator", "abc123")
``` 

### 创建其他账户

admin 账户此时只拥有用户管理的权限(指定了角色), 要想执行类似查询的操作，均会失败。

因此需要创建新的用户用于读写。

```shell
use test
db.createUser(
  {
    user: "tester",
    pwd: "abc123",
    roles: [ 
      { role: "readWrite", db: "test" },
      { role: "readWrite", db: "test2" } 
    ]
  }
)
```

此时 `test` 账户拥有数据库 `test` `test2` 的读写权。

注: 为何在 `test` 中创建的账户可以授予 **test2** 的读写权？

### 用其他账户连接 mongod

- 在连接时授权

```shell
mongo -u "tester" -p "abc123" --authenticationDatabase "test"
```

- 连接后授权

```shell
mongo
use test
db.auth("tester", "abc123")
``` 

- 插入文档

```shell
db.foo.insert({name: "foo"})
```

## 内建 Roles

### 数据库普通用户角色

- read 
- readWrite 

### 数据库管理员用户角色

- dbAmin 允许常用的文档查询，修改等
- userAdmin 允许创建修改当前数据库用户，角色
- dbOwner 拥有以上所有权限

### 全数据库角色

`admin` 数据库提供如下角色，可应用于除过 `local` 和 `config` 的所有数据库。

- readAnyDatabase
- readWriteAnyDatabase
- userAdminAnyDatabase
- dbAdminAnyDatabase

### 超级管理员角色

- dbOwner 仅当作用于 `admin` 数据库 
- userAdmin 仅当作用于 `admin` 数据库 
- userAdminAnyDatabase 

### root 角色

拥有以下所有角色

- readWriteAnyDatabase
- dbAdminAnyDatabase
- userAdminAnyDatabase
- clusterAdmin
- restore
- backup

注:

对于 mongodb 而言, role = { role: "readWrite", db: "test" } 等同于 **readWrite@test**

换言之， 角色对象中的 role 必须属于数据库 test

因此类似 role = { role: "root", db: "test" } 是不合法的, root 角色仅属于 admin, 即 **root@admin**


更多 roles 见: https://docs.mongodb.com/manual/reference/built-in-roles/