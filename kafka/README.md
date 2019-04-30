# 关键概念

- consumer: 消费实例，用于获取订阅的 topic 中一个或多个 partion 的信息。
- consumer-group: 消费实例组，同一组中的不同 consumer 会从不同的 partition 获取到不同的 message，通常组内的 consumer 数量 <= kafka partition 数量。
- topic: 订阅主题，即消息分类，具有全局唯一性。
- partition: 数据分片，通常同一个 topic 下会有多个分片，一定程度上提高可用性。
- offset: consumer 当前处理的 partion message sequence。
- commit: consumer 提交 offset 到相应的 topic partition，offset 记录存储在 kafka broker 中。
- broker: kafka cluster 中的某个 server。



















# reference

- https://dzone.com/articles/dont-use-apache-kafka-consumer-groups-the-wrong-wa
- https://www.cloudkarafka.com/blog/2016-11-30-part1-kafka-for-beginners-what-is-apache-kafka.html
