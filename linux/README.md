# 如何快速定位性能问题

## 长时间运行的后台进程

1. 使用 **top** 查看系统总的 cpu 使用率，特别需要注意 us，sys，iowait 部分，分别代表用户空间，内核时间，等待IO的时间。按 **1** 可展示所有 cpu 行(一般没啥用)
2. 使用 **pidstat 1 5** 输出每个进程详细 cpu 使用率，-p 参数可指定进程 Id
3. 使用 **perf top** 输出实时热点函数，一般可以定位到语言内的函数名
4. 使用 **perf top -g -p ${pid}** 输出指定进程的热点函数，-g 参数可以展示调用链
4. 使用 **perf record -a** 采集热点函数信息并记录到本地
5. 使用 **perf report** 展示 record 采集的数据
 
## 短时进程

- pstree
- execsnoop 

reference:

- https://github.com/Leo-G/DevopsWiki
