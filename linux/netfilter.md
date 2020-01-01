# netfilter

netfilter 可以对内核网络栈的数据包进行过滤或者修改，比如 nat 转换。iptables 用于管理配置 netfilter。

## nat

网络地址转换的缩写。

当内网主机与外部服务通信时，如果没有直接路由，那么数据包的源端口和IP会被替换为 nat 网关的ip和端口，同时映射关系会被存储在内核表 conntrack 中。

## conntrack 表更新冲突

nat 时，netfilter 框架会先检查 conntrack 表中是否已存在占用的网关端口，如果端口未占用，则插入转换记录。遗憾的是，检查和插入并不是原子操作，并发的相同的端口占用检查可能会同时成功，此时 conntrack 表的插入会因为记录重复而失败，从而引起丢包。

幸运的是 netfilter 提供了随机算法来降低端口占用检查的冲突率

- https://en.wikipedia.org/wiki/Iptables
- https://mp.weixin.qq.com/s/VYBs8iqf0HsNg9WAxktzYQ
