# 关键概念

- consumer: 消费实例，用于获取 kafka 中存储的信息。
- consumer-group: 消费实例组，同一组中的不同 consumer 会从不同的 partition 获取到不同的 message，通常组内的 consumer 数量与 kafka 的 partition 数量一致。
- topic: 订阅主题，具有唯一性。
- partition: 数据分片，通常同一个 topic 下会有多个分片，分配 consumer-group。
- offset: consumer 当前处理的 message sequence。
- commit: consumer 提交 offset 到相应的 topic partition，offset 记录存储在 kafka broker 中。




















# reference

- https://dzone.com/articles/dont-use-apache-kafka-consumer-groups-the-wrong-wa
