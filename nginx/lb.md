# 负载均衡

## 目录

+ [4层负载均衡](#4层负载均衡)
+ [7层负载均衡](#7层负载均衡)

## 4层代理

4 层代理工作在 tcp/ip 层。客户端发送 syn 到 lb 时，lb 按照负载均衡算法选择一台后端 server，并将 IP 数据包中的 dst ip 更改为后端 server ip(DNAT)。当后端 server 返回 ack 时，将 IP 数据包中的 src ip 更改为 lb ip(SNAT)。所以客户端实际上是跟后端 server 建立了连接，lb 只充当 NAT 的作用，数据包的内容对 lb 来说是透明的。

## 7层代理

7 层代理工作在应用层。客户端先跟 lb 建立连接，lb 读取并解析数据包内容(http header、url等)后，按照一定规则(例如 nginx 的 location 匹配)再转发到后端 server。
