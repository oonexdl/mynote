
# 是什么?

Borg 的一个开源版本，基于容器技术，目的是实现资源管理的自动化，以及跨多个数据中心的资源利用率的最大化。

k8s 提供的解决方案：

- 负载均衡器
- 服务治理框架
- 服务监控
- 故障处理

# 关键概念

- serivce: 拥有唯一指定的名字，拥有虚拟 IP 和端口号，提供远程服务能力，映射到一组服务容器上。
- pod: 封装 service 对应的那组容器。拥有 pause 容器 + 服务容器，服务容器共享 pause 容器的网络栈和 volume。
- Master 节点: 用于集群管理，运行 kube-apiserver、kube-controller-manager、kube-scheduler，实现了资源管理、Pod 调度、弹性伸缩、安全控制、系统监控和纠错。
- Node 节点: 运行真正的应用程序，管理的最小单元为 Pod。运行 kubelet、kube-proxy，负责 Pod 的创建、启动、监控、重启、销毁，以及负载均衡器。
- RC(replication controller): 用于服务扩容和升级。包括目标 Pod 的定义，需要运行的副本数量，要监控的目标 Pod 的标签。
- kube-apiserver: 提供 http rest 接口，k8s 中所有资源的增删改查的唯一入口。
- kube-controller-manager: 资源对象自动化控制中心。
- kube-scheduler: 负责资源(Pod)调度。
- kubelet: 负责容器的创建，启停等任务。
- kube-proxy: 实现 k8s service 的通讯与负载均衡机制。

# 常用命令

```
# 获取 RC 列表
kubectl get rc
# 获取 Pod 列表
kubectl get pods
# 获取服务列表
kubectl get svc
# 获取 Node 列表
kubectl get nodes
# 查看 node 详细信息
kubectl describe node {node_name}
# 查看 Pod 详细信息
kubectl describe pod {pod_name}
# 修改 RC 数量
kubectl scale rc {rc_name} --replicas=3
# 获取 EndPoint 列表
kubectl get endpoints
# 依据 rc 创建 service
kubectl expose rc webapp
```

# Pod

pause 容器不易死亡，以它的状态代表整个容器组的状态。Pod 内业务容器共享 pause 容器的 IP，volume。简化了通信，解决了文件共享。

每个 Pod 都被分配了唯一的 IP 地址，称之为 Pod IP。k8s 集群内，任意两个 Pod 可以使用 TCP/IP 直接通信。

# Label

使用 Label 可以给对象创建多组标签，Label 和 Label Selector 构成了 k8s 系统中最核心的应用模型。

# RC

定义了一个期望的场景，即声明某种 Pod 的副本数量都符合某个期望值，包含以下部分:

- 期待的副本数 replicas
- 用于筛选目标 Pod 的 Label Selector
- 用于创建新 Pod 的模板

# Deployment

使用 Replica Set 来实现，区别于 RC 的特点是可以知道当前 Pod 部署的进度。

# Horizontal Pod Autoscaler(HPA)

即横向自动扩容。通过追踪分析 RC 控制的所有目标 Pod 的负载变化情况，来确定是否需要针对性的调整目标 Pod 的副本数。
两种方式作为度量指标:

- CPUUtilizationPercentage，目标 Pod 所有副本自身的 CPU 利用率的平均值(通常一分钟内)。
- 应用程序自定义的度量指标

# Service

定义了一个服务的入口地址。对 service 的请求，通过 kube-proxy 转发到后端的某个 Pod 实例上，内部实现负载均衡和会话保持。每个 service 分配一个唯一的虚拟 IP，称为 Cluster IP，在 service 的整个生命周期中该 IP 不会发生改变。因此只需要根据服务名称和 Cluster IP 做一个 DNS 域名映射，即可实现服务发现。

- clusterIp 仅作用于 Kubernetes Service 这个对象。
- clusterIp 无法被 ping，只能结合 Service Port 组成一个具体的通信端口。

负载均衡策略:

- RoundRobin: 轮询模式。
- SessionAffinity: 基于客户端 IP 进行会话保持的模式。

## 集群外访问 Pod 或 Service

1. 将容器应用的端口号映射到物理机
  - 设置 hostPort 为物理机映射端口
  - 设置 Pod 级别的 hostNetWork=true，容器内所有端口号均映射到物理机上
2. 将 service 的端口号映射到物理机
  - 设置 nodePort，同时设置 Service 的类型为 NodePort
  - 设置 LoadBalancer 映射到云服务商提供的 LoadBalancer 地址

# Controller Manager

## Replication Controller

- 确保及集群中有且仅有 N 个 Pod 实例，N 是 RC 中定义的 Pod 副本数量。
- 通过调整 sepc.replicas 属性实现系统扩容或收缩。
- 通过改变 RC 的 Pod 模板来实现系统的滚动升级。

## Node Controller

# Scheduler

## 承上启下

- 承上: 负责接收 Controller Manager 创建的新 Pod，为其安排 Node 节点。
- 启下: 目标 Node 上的 kubelet 接管后继工作，负责 Pod 的生命周期。

# 网络模型

## network namespace
## veth 设备对
## 网桥
## Iptables/Netfilter
## 路由

# Flannel

- 给每个 node 上的 docker 容器分配不冲突的 IP 地址。
- 在这些 IP 地址之间建立覆盖网络，通过覆盖网络，数据包可以原封不动的传递到目标容器内。

