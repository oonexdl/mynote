# etcd

基于raft(分布式共识算法)的高可用键值存储系统

## raft

原文：https://raft.github.io/raft.pdf

知乎翻译：https://zhuanlan.zhihu.com/p/27207160

### 一致性

在一个具有一致性的性质的集群里面，同一时刻所有的结点对存储在其中的某个值都有相同的结果，即对其共享的存储保持一致

### 角色

1. Leader：请求处理者，分发更新到 Follower
2. Follower：接受 Leader 分发的更新，写入本地日志
3. Candidate：如果检测到 Leader 失联，Follower 转换为 Candidate，进行选举

### Leader选举

时间被分为很多连续的随机长度term，每个term有唯一id，选主开始：

1. Follower的current_item_id加1
2. 状态改为 Candidate
3. 发送 requestVoteRPC 到其他节点

选主结束可能有如下结果：

- 成为leader。定期给其他节点发送心跳，告诉对方自己是current_item_id的leader，其他节点收到rpc消息后，比较本地item_id与rpc消息中的item_id。如果更小，更新本地item_id，变更自己角色为Follower
- 其他人成为leader。
- 票被瓜分，无主选出。等待投票超时，进行下一轮选举。

投票策略：

1. 每个节点只能给每个term投一票，是否投票取决于Safety.1
2. 票被瓜分后，所有candidate会同时发起下一轮投票，可能会再次瓜分投票。通过让每个节点的选举超时时间随机，来避免这一点。这样首次超时的节点，可以率先发起requestVoteRPC，获得其他节点的同意票。

### Log Replication

Leader被选举出后，可以接受客户端请求。每个请求会产生一条log entry并写入本地，然后给其他节点发送appendEntryRPC请求，当大多数节点已经成功写入日志后，该条log entry被commit到RSM中，返回结果到客户端。如果某个Follower无响应，则一直重试appendEntryRPC，直到成功。

### Safety

1. 被选举的新leader必须拥有所有已提交的日志
2. leader分发日志给其他节点，如果大多数节点(一半多一个)已经写盘，则该日志被认为已提交(commited)

### Protocol Amendment

只允许主节点提交包含当前term的日志，避免已持久化的日志回滚。

### Log Compaction

定期做日志快照
1. 元数据记录最后一条commited log entry
2. 记录系统状态？

### Cluster Topology Change

配置分二阶段推送，防止出现多主
1. Cold U Cnew
2. Cnew
