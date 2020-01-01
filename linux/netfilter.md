# netfilter

netfilter 可以对内核网络栈的数据包进行过滤或者修改，比如 nat 转换。iptables 用于管理配置 netfilter。

# nat

网络地址转换的缩写。

当内网主机与外部服务通信时，如果没有直接路由，那么数据包的源端口和IP会被替换为 nat 网关的ip和端口，同时映射关系会被存储在内核表 conntrack 中。

## conntrack 表更新冲突
