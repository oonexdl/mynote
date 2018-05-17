```
db.runCommand({
        // 必须带 ns
        splitVector:"blog.article",
        // 必须加索引，或者使用其它已有索引的 key（值需足够分散，否则 chunk 会过大）
        keyPattern:{categoryId:1,_id:1},
        // 可选，split 下限
        min:{categoryId:ObjectId('58d2112d829fa700204bacc4')},
        // 可选，split 上限，不能与 min 相同，否则报 can't open a cursor for splitting (desired range is possibly empty ，可以加 1 来 workaround
        max:{categoryId:ObjectId('58d2112d829fa700204bacc5')},
        // 最大 chunk 大小，单位 MB ，必须指定
        maxChunkSize:10, 
        // 可选，chunk 内最大条数
        maxChunkObjects:500
})
{
    "timeMillis" : 58,
    "splitKeys" : [
        {
            "categoryId" : ObjectId("58d2112d829fa700204bacc4"),
            "_id" : ObjectId("5947b90eb40c340519610c0c")
        },
        {
            "categoryId" : ObjectId("58d2112d829fa700204bacc4"),
            "_id" : ObjectId("5947b90eb40c340519610d01")
        },
        {
            "categoryId" : ObjectId("58d2112d829fa700204bacc4"),
            "_id" : ObjectId("5947b90fb40c340519610gf6")
        },
        {
            "categoryId" : ObjectId("58d2112d829fa700204bacc4"),
            "_id" : ObjectId("5947b910b40c340519610eeb")
        },
        ...
}

db.article.count({categoryId:ObjectId("58d2112d829fa700204bacc4"),_id:{$lt:ObjectId("5947b90eb40c340519610c0c")}})
db.article.count({categoryId:ObjectId("58d2112d829fa700204bacc4"),_id:{$gte:ObjectId("5947b90eb40c340519610c0c"),$lt:ObjectId("5947b90eb40c340519610d01")}})
```
