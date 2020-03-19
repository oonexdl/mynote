# tcp/ip

## TIME_WAIT

tcp 哪边主动断开哪边产生 TIME_WAIT，比如 nginx 在处理短链接时会主动断开客户端连接，在机器上会有大量同一监听端口的 tcp 链接，可以修改 tcp_max_tw_buckets 来应对短链接冲击。

https://coolshell.cn/articles/1484.html

## tcpdump 

```
tcpdump -i eth0 -nn -s0 -v port 8000 -w dump.pcap
```

## wireshark

filter: ip.src==100.116.204.199 or ip.dst==100.116.204.199 and tcp.port eq 31390
