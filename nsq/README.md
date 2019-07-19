## 关键概念

- nsqd: 负责储存和分发消息给消费者
- nsqlookupd: 负责 nsqd 的服务发现
- topic: 消息分发的一级渠道
- channel: topic 的下级，跟一般理解不同，channel 不用于消息分类，仅仅拷贝一份 topic 的数据，提供给不同来源订阅
- consumer: 订阅 topic/channel
- producer: 写消息到 topic
