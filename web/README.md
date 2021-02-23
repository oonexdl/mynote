目录
=================

+ [跨域请求](#cors)
+ [http发展史](#http)

# cors

何为跨域请求？

发起 xmlhttprequest 的 host(request header 为 origin) 与目的 host 不同，则为跨域请求

# http

## http/1.0

在浏览器加载网页的传统 web 场景下，由于首页 html 中会存在大量的 link 资源，浏览器不得不发起额外的 http 请求来获取资源。而每次发起的 http 请求都将建立新的 TCP connection，这意味着更多的时间以及网络资源消耗。

## http/1.1

HTTP/1.1 使用长连接(keepalive)和管道技术解决了上述问题。浏览器可以复用同一个 TCP 连接来发起多个请求，请求像通过管道一样被依次处理。这在性能上有很大提升，但依旧存在问题。例如，假设一系列请求中的第一个因为服务端的某些原因出现了超时，将会导致整个管道出现阻塞(head-of-line (HOL) blocking)。解决 HOL 的方法之一就是使用更多的 TCP 连接，这同样造成一定程度上的资源浪费。

## http/2

在 http/2 中，客户端与服务端之间仅维护一个 TCP 连接。另外，不同于 http/1 的文本传输格式，http/2 将数据处理为二进制格式。格式层级为 stream => messages = > frames，最底层的 frames 作为最终的数据交换格式。frames 通过 tag 标识属于哪个 stream。基于这样的设计，多个 stream 可以实现交错传输，这也意味着 http 客户端与服务端之间可以并发处理请求。

### Stream 优先级

### Server Push

### Compression
