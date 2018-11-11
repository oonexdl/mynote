依赖于 consul 的服务注册功能，每个 service 被一个 containerpolit 实例管理其生命周期。

1. if service healthy，register service to consul
2. healthy event broadcast to all listeners
3. listeners update serviceDependence config by query from consul

例如有如下服务组件:

- nginx    [service1 service2 service3]
- service1    [service2]
- service2    [service1]
- service3    [service1]

服务 1,2,3 成功启动，nginx 监听到服务启动的 events，向 consul 查询服务地址，用 consul-template 服务更新 nginx 配置文件，发送 signhup 信号给 nginx daemon
