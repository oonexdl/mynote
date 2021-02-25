# grpc 使用规范

+ [http1.1 to grpc](#http1.1 to gRPC)
+ [错误处理](#错误处理)

## http1.1 to gRPC

比较常见的应用场景是客户端无法用 gRPC 协议和后端服务直接通信。目前有以下几种方式来处理 http1.1 到 gRPC 的转换：

1. 构建网关服务转换协议. 优点是实现灵活，适合于老服务到 gRPC 的升级迁移。
  1. 手动编写 json 与 protobuf message 之间的 encode/decode 代码。
  2. 使用 https://github.com/grpc-ecosystem/grpc-gateway。
  3. 编写 protoc plugin 生成自定义的转换代码。
2. 使用 envoyproxy 作为应用服务的 sidecar。优点是对服务的侵入性弱，可以作为 Istio service mesh 生态的一部分。
  - [gRPC HTTP/1.1 bridge](https://www.envoyproxy.io/docs/envoy/latest/configuration/http/http_filters/grpc_http1_bridge_filter) 使用 client proxy 实现 http1.1 到 http2 的协议层转换。缺点是客户端请求的 header 和 body 需要遵循一定的格式。
  - [gRPC-JSON transcoder](https://www.envoyproxy.io/docs/envoy/latest/configuration/http/http_filters/grpc_json_transcoder_filter) 类似 grpc-gateway。

## 错误处理

推荐直接使用 gRPC 定义的 status code 表达错误，如果表达力不够，说明微服务划分的还不够合理。如果需要自定义业务错误码(面向客户端设备)，请使用服务网关聚合层(bff)。

https://grpc.io/docs/guides/error/

[google error model](https://cloud.google.com/apis/design/errors#error_model)

[google error code && http status code map](https://github.com/googleapis/googleapis/blob/master/google/rpc/code.proto)
