# 示例

// iterate.js
```js
print("my_var: ", my_var);

var cursor = db.user.find({phone:{"$exists":true, "$ne":""}, encryptedPhone:{"$exists":false}}).noCursorTimeout();

print("startAt: "+Date());

cursor.forEach(function(user) {
    user.encryptedPhone = hex_md5(user.phone)
    db.user.save(user);
});

print("endAt: "+Date());

cursor.close();
```

// 在 mongo shell 种执行
```
mongo $DATABASE -uroot -proot --eval "var my_var='$GOPATH'" iterate.js
```
